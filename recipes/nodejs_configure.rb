#
# Cookbook Name:: btc-infrastructure
# Recipe:: nodejs_configure
#
# Author:: Steven Kroh
#
# Copyright 2016, Adventure Cycling Association

log 'configuring an application layer instance'

stack = search('aws_opsworks_stack').first
stack_name = stack['name']

log "stack name: #{stack_name}"

database_layer = search('aws_opsworks_layer', 'shortname:database').first
id = database_layer['layer_id']

log "database layer id: #{id}"

# Start by assuming there is not databsase server instance to connect to
domain = false

# The development stack only supports a single database server instance.
# In this case, connect to it via its private ip. The database server will
# permit connections by security group rule.
if stack_name.include? 'dev'
  instance = search('aws_opsworks_instance', "layer_ids:#{id}").first
  domain = instance['private_ip'] if instance
# The production and staging stacks manage multiple database servers behind
# an elastic load balancer. Connect by the ELB's dns name.
else
  elb = search('aws_opsworks_elastic_load_balancer', "layer_id:#{id}").first
  domain = elb['dns_name'] if elb
end

# If there is a database server, set SERVER_COUCH_DOMAIN. Otherwise, unset
# the variable. Unsetting the variable will cause the api service
if domain
  log "database server domain: #{domain}"

  env 'SERVER_COUCH_DOMAIN' do
    value domain
    action :create
  end
else
  log 'database server domain: NA'

  env 'SERVER_COUCH_DOMAIN' do
    action :delete
  end
end

# Restart the service to pull in the modified environment variable
windows_service node['server']['name'] do
  action :restart
end
