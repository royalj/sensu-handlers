#
# Cookbook Name:: sensu-handlers
# Recipe:: mailer
#

sensu_gem 'mail' do
  version '2.5.4'
  options('--no-rdoc --no-ri')
end

cookbook_file 'mailer.rb' do
  path "#{node['sensu-handlers']['handler_dir']}/mailer.rb"
  action :create_if_missing
  backup false
  owner 'sensu'
  group 'sensu'
  mode '0644'
end

sensu_handler 'mailer' do
  type 'pipe'
  command "#{node['sensu-handlers']['handler_dir']}/mailer.rb"
  additional(
    teams: node['sensu-handlers']['teams'],
    mail_from: "sensu@#{node['domain']}"
  )
end
