# Description

## WORK IN PROGRESS
# sensu-handlers
This cookbook is a Chef implementation of Yelp's sensu_handlers Puppet module. The purpose of this
cookbook is to enable Sensu checks to be configured to define the desired handler behavior within
the check itself. This allows you to include a single handler ('default') in the Sensu checks and
let the logic within the handlers, along with the additional check parameters to decide whether to
handle events. This cookbook also allows you to define a 'teams' hash to provide more dynamic
contact routing.

**WARNING:** These handlers require special event data (such as the 'teams' hash) in order to work.
If this data is not provided, these handlers will do nothing.
# Requirements

## Platform:

*No platforms defined*

## Cookbooks:

* sensu (~> 2.10.0)

# Attributes

* `node['sensu-handlers']['handler_dir']` - Directory where Sensu handler scripts are stored. Defaults to `/opt/sensu/handlers`.
* `node['sensu-handlers']['teams']` - Hash to define the different teams, which will effect the behavior of the handlers. Defaults to `{ ... }`.
* `node['sensu-handlers']['default_handler_array']` - Array of handlers you want created. Array elements correspond to included recipes. Defaults to `%w(pagerduty mailer)`.
* `node['sensu-handlers']['dashboard_link']` -  Defaults to `https://sensu.#{node['domain']}`.
* `node['sensu-handlers']['jira_username']` -  Defaults to `sensu`.
* `node['sensu-handlers']['jira_password']` -  Defaults to `sensu`.
* `node['sensu-handlers']['jira_site']` -  Defaults to `jira.#{node['domain']}`.

# Recipes

* sensu-handlers/::default
* sensu-handlers/::mailer
* sensu-handlers/::pagerduty

# License and Maintainer

Maintainer:: Jacob Royal (<j.w.r.1215@gmail.com>)

License:: Apache 2.0
