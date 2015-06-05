# WORK IN PROGRESS
The mailer and pagerduty handlers/scripts are my first priority to get working. Due to some 
differences in how the sensu puppet module and the sensu chef cookbook create handlers the 
scripts are having some small refactoring done. I'm no Ruby or Chef wizard so
question/comments/concerns are welcome. Also right now writing spec and integration tests 
haven't taken a priority, but once I'm closer to a stable first pass tests will be added.

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

### Set within recipe/atribute file

```
default['sensu-handlers']['teams'] = \ # add node.default... if setting within recipe
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
