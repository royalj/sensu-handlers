default['sensu-handlers']['teams'] = {}
default['sensu-handlers']['default_handler_array'] = %w(pagerduty mailer)
default['sensu-handlers']['dashboard_link'] = "https://sensu.#{node['domain']}"

# Default JIRA credentials
default['sensu-handlers']['jira_username'] = 'sensu'
default['sensu-handlers']['jira_password'] = 'sensu'
default['sensu-handlers']['jira_site'] = "jira.#{node['domain']}"
