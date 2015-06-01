#
# Cookbook Name:: sensu-handlers
# Recipe:: pagerduty
#
# == Class: sensu_handlers::pagerduty
#
# Sensu handler for communicating with Pagerduty
#

sensu_gem 'redphone'

sensu_handler 'pagerduty' do
  type 'pipe'
  command "#{node['sensu-handlers']['handler_dir']}/pagerduty.rb"
  severities %w(critical unknown)
  additional(
    teams: node['sensu-handlers']['teams']
  )
end
