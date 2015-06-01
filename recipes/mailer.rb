#
# Cookbook Name:: sensu-handlers
# Recipe:: mailer
#

sensu_gem 'mail' do
  version '2.5.4'
  options('--no-rdoc --no-ri')
end

sensu_handler 'mailer' do
  type 'pipe'
  command "#{node['sensu-handlers']['handler_dir']}/mailer.rb"
  additional(
    teams: node['sensu-handlers']['teams']
  )
end
