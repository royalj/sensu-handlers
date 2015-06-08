#
# Cookbook Name:: sensu-handlers
# Recipe:: default
#
include_recipe 'sensu-handlers::_sensu'

directory '/opt/sensu/handlers' do
  owner 'sensu'
  group 'sensu'
  mode '0755'
  recursive true
end

attributes = node['sensu-handlers']

cookbook_file 'base.rb' do
  path "#{attributes['handler_dir']}/base.rb"
  backup false
  owner 'sensu'
  group 'sensu'
  mode '0755'
end

include_recipe 'sensu-handlers::_sensu'

reg = /::.*/
default_handler_array = []

attributes['default_handlers'].each do |x|
  x = x.match(reg).to_s.gsub(/:/, '')
  default_handler_array << x
end

sensu_handler 'default' do
  type 'set'
  handlers default_handler_array
  additional(
    dashboard_link: attributes['dashboard_link']
  )
end

# Include the recipes for the handlers defined in the default_handler_array attribute
attributes['default_handlers'].each do |handler|
  include_recipe handler
end
