#<> Directory where Sensu handler scripts are stored
default['sensu-handlers']['handler_dir'] = '/opt/sensu/handlers'

# See the README for examples of the 'teams' attribute
#<> Hash to define the different teams, which will effect the behavior of the handlers.
default['sensu-handlers']['teams'] = {}

#<> Array of handlers you want created. Array elements correspond to included recipes.
default['sensu-handlers']['default_handler_array'] = %w(pagerduty mailer)

default['sensu-handlers']['dashboard_link'] = "https://sensu.#{node['domain']}"

# Default JIRA credentials
default['sensu-handlers']['jira_username'] = 'sensu'
default['sensu-handlers']['jira_password'] = 'sensu'
default['sensu-handlers']['jira_site'] = "jira.#{node['domain']}"
