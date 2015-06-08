#
# Cookbook Name:: sensu-handlers
# Spec:: mailer
#

require 'spec_helper'

describe 'sensu-handlers::mailer' do
  let(:chef_run) do
    ChefSpec::SoloRunner.new(
      platform: 'centos', version: '6.5') do |node|
      node.automatic['domain'] = 'example.com'
      node.force_default['sensu-handlers']['teams'] =
        {
          'test' => {
            'notification_email' => 'tester@example.com'
          }
        }
    end.converge(described_recipe)
  end
  subject { chef_run }

  it 'Install mail gem' do
    is_expected.to install_sensu_gem('mail')
      .with_version('2.5.4')
      .with_options('--no-rdoc --no-ri')
  end

  it 'Creates/updates mailer.rb' do
    is_expected.to create_cookbook_file('mailer.rb')
      .with_path('/opt/sensu/handlers/mailer.rb')
      .with_owner('sensu')
      .with_group('sensu')
      .with_mode('0755')
  end

  it 'Creates mailer handler' do
    is_expected.to create_sensu_handler('mailer')
      .with_type('pipe')
      .with_command('/opt/sensu/handlers/mailer.rb')
      .with_severities(%w(ok warning critical unknown))
      .with_additional(
        teams: { 'test' => { 'notification_email' => 'tester@example.com' } },
        mail_from: 'bke_sensu@example.com'
      )
  end
end
