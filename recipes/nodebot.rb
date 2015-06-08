#
# Cookbook: sensu-handlers
# Recipe: nodebot
#

cookbook_file 'nodebot.rb' do
  path "#{node['sensu-handlers']['handler_dir']}/nodebot.rb"
  action :create_if_missing
  backup false
  owner 'sensu'
  group 'sensu'
  mode '0755'
end

sensu_handler 'nodebot' do
  type 'pipe'
  command "#{node['sensu-handlers']['handler_dir']}/nodebot.rb"
  additional(
    teams: node['sensu-handlers']['teams']
  )
end
