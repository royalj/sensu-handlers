#<> Directory where Sensu handler scripts are stored
default['sensu-handlers']['handler_dir'] = '/opt/sensu/handlers'

# See the README for examples of the 'teams' attribute
#<> Hash to define the different teams, which will effect the behavior of the handlers.
default['sensu-handlers']['teams'] = {}

#<> Array of handlers you want created.
# Array elements correspond to included recipes. By including the cookbook it allows users to
# append this array to use handlers outside the scope of this cookbook.
default['sensu-handlers']['default_handlers'] = \
  %w(sensu-handlers::pagerduty sensu-handlers::mailer)

default['sensu-handlers']['dashboard_link'] = "https://sensu.#{node['domain']}"

#<> Boolean to determine if aws_prune recipe should be included
default['sensu-handlers']['enable_aws_prune'] = false

# Default JIRA credentials
default['sensu-handlers']['jira_username'] = 'sensu'
default['sensu-handlers']['jira_password'] = 'sensu'
default['sensu-handlers']['jira_site'] = "jira.#{node['domain']}"

# Disable ssl by default
default['sensu']['use_ssl'] = false
default['sensu']['rabbitmq']['port'] = '5672'
default['sensu']['use_embedded_ruby'] = true
