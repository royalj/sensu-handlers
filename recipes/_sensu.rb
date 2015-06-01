# In order to use LWRP's provided by the Sensu cookbook, you have to include the default recipe
include_recipe 'sensu'

# This keeps the Sensu cookbook from laying down any of the config files
resources(sensu_base_config: node.name).action(:nothing)
