#
# Cookbook Name:: sensu-handlers
# Recipe:: pagerduty
#

sensu_gem 'redphone'

cookbook_file 'pagerduty.rb' do
  path "#{node['sensu-handlers']['handler_dir']}/pagerduty.rb"
  backup false
  owner 'sensu'
  group 'sensu'
  mode '0755'
end

subdue = node['sensu-handlers']['subdue']['pagerduty']

sensu_handler 'pagerduty' do
  type 'pipe'
  command "#{node['sensu-handlers']['handler_dir']}/pagerduty.rb"
  severities %w(critical unknown)
  additional(
    teams: node['sensu-handlers']['teams'],
    subdue: subdue
  )
end
