#!/usr/bin/env ruby
#
# Sensu Handler: mailer
#
# This handler formats alerts as mails and sends them off to a pre-defined recipient.
#
# Copyright 2012 Pal-Kristian Hamre (https://github.com/pkhamre | http://twitter.com/pkhamre)
#
# Released under the same terms as Sensu (the MIT license); see LICENSE
# for details.

require 'rubygems' if RUBY_VERSION < '1.9.0'
require 'sensu-handler'
gem 'mail', '~> 2.5.4'
require 'mail'
require 'timeout'

# rubocop:disable Style/ClassAndModuleChildren
# patch to fix Exim delivery_method: https://github.com/mikel/mail/pull/546
module ::Mail
  # See above comment
  class Exim < Sendmail
    def self.call(path, arguments, _destinations, encoded_message)
      popen "#{path} #{arguments}" do |io|
        io.puts encoded_message.to_lf
        io.flush
      end
    end
  end
end
# rubocop:enable Style/ClassAndModuleChildren

require "#{File.dirname(__FILE__)}/base"

# Simple mailer handler
class Mailer < BaseHandler
  def short_name
    @event['client']['name'] + '/' + @event['check']['name']
  end

  def action_to_string
    @event['action'].eql?('resolve') ? 'RESOLVED' : 'ALERT'
  end

  def mail_destination
    if @event['check']['notification_email'] == 'false'
      false
    elsif @event['check']['notification_email'] == ''
      false
    elsif @event['check']['notification_email'] == 'undef'
      # 'undef' is what puppet puts in, when left undefined
      team_data('notification_email')
    elsif !@event['check']['notification_email'].nil?
      @event['check']['notification_email']
    else
      team_data('notification_email')
    end
  end

  def handle
    mail_to = mail_destination
    # Only procede if we have an email address to work with
    return false unless mail_to

    mail_from = "sensu@#{settings['handlers'][self.class.name.downcase]['mail_from']}"

    mailer = settings['handlers']

    delivery_method = mailer['delivery_method'] || 'smtp'
    smtp_address = mailer['smtp_address'] || 'localhost'
    smtp_port = mailer['smtp_port'] || '25'
    smtp_domain = mailer['smtp_domain'] || 'localhost.localdomain'

    smtp_username = mailer['smtp_username'] || nil
    smtp_password = mailer['smtp_password'] || nil
    smtp_authentication = mailer['smtp_authentication'] || :plain
    smtp_enable_starttls_auto = mailer['smtp_enable_starttls_auto'] == 'false' ? false : true

    body = full_description
    subject = "#{action_to_string} - #{short_name}: #{@event['check']['notification']}"

    Mail.defaults do
      delivery_options = {
        address: smtp_address,
        port: smtp_port,
        domain: smtp_domain,
        openssl_verify_mode: 'none',
        enable_starttls_auto: smtp_enable_starttls_auto
      }

      unless smtp_username.nil?
        auth_options = {
          user_name: smtp_username,
          password: smtp_password,
          authentication: smtp_authentication
        }
        delivery_options.merge! auth_options
      end

      delivery_method delivery_method.intern, delivery_options
    end

    begin
      timeout 10 do
        Mail.deliver do
          to mail_to
          from mail_from
          subject subject
          body body
        end

        puts "mail -- sent alert for #{short_name} to #{mail_to}"
      end
    rescue Timeout::Error
      puts "mail -- timed out while attempting to #{@event['action']} an incident -- #{short_name}"
    end
  end
end
