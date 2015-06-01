# Description

# WORK IN PROGRESS

# sensu-handlers

This cookbook is a Chef implementation of Yelp's sensu_handlers Puppet module. The purpose of this
cookbook is to enable Sensu checks to be configured to define the desired handler behavior within
the check itself. This allows you to include a single handler (`default`) in the Sensu checks and
let the logic within the handlers, along with the additional check parameters to decide whether to
handle events. This cookbook also allows you to define a `teams` hash to provide more dynamic
contact routing.

**WARNING:** These handlers require special event data (such as the `teams` hash) in order to work.
If this data is not provided, these handlers will do nothing.

## Setting `node['sensu-handlers']['teams']`

The simplest way to set the `teams` attribute is to do so explicitly within a recipe, but
you can also utilize a Chef data bag to store and load team information.

### Set within recipe

```
node.default['sensu-handlers']['teams'] = \
{
  ops: {
    pagerduty_api_key: '11111',
    notification_email: 'ops@mail.com'
  },
  devs: {
    pagerduty_api_key: '22222',
    pages_irc_channel: 'devs-pages',
    notifications_irc_channel: 'developers',
    notification_email: 'devs@mail.com'
  },
  hardware: {
    pagerduty_api_key: '11111',
    project: 'METAL'
  }
}
```

### data_bag_item:

```
{
  "id": "default",
  "teams": {
    "ops": {
      "pagerduty_api_key": "11111",
      "notification_email": "ops@mail.com"
    },
    "devs": {
      "pagerduty_api_key": "22222",
      "pages_irc_channel": "devs-pages",
      "notifications_irc_channel": "developers",
      "notification_email": "devs@mail.com"
    },
    "hardware": {
      "pagerduty_api_key": "11111",
      "project": "METAL"
    }
  }
}
```

Set `teams` attribute in recipe by loading data bag item:

```
  data_bag_item = 'default'
  node.default['sensu-handlers']['teams'] = data_bag_item('sensu-handlers', data_bag_item['teams'])
```

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
* `node['sensu-handlers']['enable_aws_prune']` - Boolean to determine if aws_prune recipe should be included. Defaults to `false`.
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
