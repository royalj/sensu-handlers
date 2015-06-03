#
# Cookbook Name:: sensu-handlers
# Recipe: jira
#

sensu_gem 'jira-ruby' do
  version '0.1.9'
  options('--no-rdoc --no-ri')
end

cookbook_file 'jira.rb' do
  path "#{node['sensu-handlers']['handler_dir']}/jira.rb"
  action :create_if_missing
  backup false
  owner 'sensu'
  group 'sensu'
  mode '0644'
end

attributes = node['sensu-handlers']

sensu_handler 'jira' do
  type 'pipe'
  command "#{node['sensu-handlers']['handler_dir']}/jira.rb"
  additional(
    teams: node['sensu-handlers']['teams'],
    username: attributes['jira_username'],
    password: attributes['jira_password'],
    site: attributes['jira_site']
  )
end
