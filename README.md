# Description


# Requirements

## Platform:

*No platforms defined*

## Cookbooks:

* sensu (~> 2.10.0)

# Attributes

* `node['sensu-handlers']['teams']` -  Defaults to `{ ... }`.
* `node['sensu-handlers']['default_handler_array']` -  Defaults to `%w(pagerduty mailer)`.
* `node['sensu-handlers']['dashboard_link']` -  Defaults to `https://sensu.#{node['domain']}`.
* `node['sensu-handlers']['jira_username']` -  Defaults to `sensu`.
* `node['sensu-handlers']['jira_password']` -  Defaults to `sensu`.
* `node['sensu-handlers']['jira_site']` -  Defaults to `jira.#{node['domain']}`.

# Recipes

* sensu-handlers/::default

# License and Maintainer

Maintainer:: Jacob Royal (<j.w.r.1215@gmail.com>)

License:: Apache 2.0
