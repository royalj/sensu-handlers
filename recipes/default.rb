#
# Cookbook Name:: sensu-handlers
# Recipe:: default
#

attributes = node['sensu-handlers']

cookbook_file 'base.rb' do
  path "#{attributes['handler_dir']}/base.rb"
  action :create_if_missing
  backup false
  owner 'root'
  group 'root'
  mode '0644'
end

include_recipe 'sensu-handlers::_sensu'

sensu_handler 'default' do
  type 'set'
  command true
  handlers attributes['default_handler_array']
  additional(
    dashboard_link: attributes['dashboard_link']
  )
end

# Include the recipes for the handlers defined in the default_handler_array attribute
attributes['default_handler_array'].each do |handler|
  include_recipe handler
end
