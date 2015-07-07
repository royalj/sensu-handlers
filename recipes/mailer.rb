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
  backup false
  owner 'sensu'
  group 'sensu'
  mode '0755'
end

subdue = node['sensu-handlers']['subdue']['mailer']


sensu_handler 'mailer' do
  type 'pipe'
  command "#{node['sensu-handlers']['handler_dir']}/mailer.rb"
  severities %w(ok warning critical unknown)
  additional(
    subdue: subdue,
    teams: node['sensu-handlers']['teams'],
    mail_from: node['sensu-handlers']['mail_from'],
    smtp_config: node['sensu-handlers']['smtp_config']
  )
end
