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