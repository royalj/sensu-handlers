#
# Cookbook Name:: sensu-handlers
# Recipe:: pagerduty
#

sensu_gem 'redphone'

cookbook_file 'pagerduty.rb' do
  path "#{node['sensu-handlers']['handler_dir']}/pagerduty.rb"
  action :create_if_missing
  backup false
  owner 'sensu'
  group 'sensu'
  mode '0644'
end

sensu_handler 'pagerduty' do
  type 'pipe'
  command "#{node['sensu-handlers']['handler_dir']}/pagerduty.rb"
  severities %w(critical unknown)
  additional(
    teams: node['sensu-handlers']['teams']
  )
end
