# btc_infrastructure -- Cookbook for the Bicycle Touring Companion
# Copyright (C) 2016 Adventure Cycling Association
#
# This file is part of btc_infrastructure.
#
# btc_infrastructure is free software: you can redistribute it and/or modify
# it under the terms of the Affero GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# btc_infrastructure is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# Affero GNU General Public License for more details.
#
# You should have received a copy of the Affero GNU General Public License
# along with btc_infrastructure.  If not, see <http://www.gnu.org/licenses/>.

log 'configuring an application layer instance'

stack = search('aws_opsworks_stack').first
stack_name = stack['name']

log "stack name: #{stack_name}"

database_layer = search('aws_opsworks_layer', 'shortname:database').first
id_d = database_layer['layer_id']

log "database layer id: #{id_d}"

application_layer = search('aws_opsworks_layer', 'shortname:application').first
id_a = application_layer['layer_id']

log "application layer id: #{id_a}"

# Start by assuming there is not databsase server instance to connect to
couch_domain = false
domain = false

# The development stack only supports a single database server instance.
# In this case, connect to it via its private ip. The database server will
# permit connections by security group rule. Connect to the app server via its
# public IP.
if stack_name.include? 'dev'
  instance = search('aws_opsworks_instance', "layer_ids:#{id_d}").first
  couch_domain = instance['private_ip'] if instance
  domain = instance['public_ip'] if instance
# The production and staging stacks manage multiple database servers behind
# an elastic load balancer. Connect by the ELB's dns name. Connect to the
# app server via its ELB's dns name.
else
  elb = search('aws_opsworks_elastic_load_balancer', "layer_id:#{id_d}").first
  couch_domain = elb['dns_name'] if elb

  elb = search('aws_opwsorks_elastic_load_balancer', "layer_id:#{id_a}").first
  domain = elb['dns_name'] if elb
end

# If there is a database server, set SERVER_COUCH_DOMAIN. Otherwise, unset
# the variable. Unsetting the variable will cause the api service to use the
# default from the config YAMLs.
if couch_domain
  log "database server couch_domain: #{couch_domain}"

  env 'SERVER_COUCH_DOMAIN' do
    value couch_domain
    action :create
  end
else
  log 'database server couch_domain: NA'

  env 'SERVER_COUCH_DOMAIN' do
    action :delete
  end
end

# If we can find our own address, set SERVER_DOMAIN. Otherwise, unset
# the variable. Unsetting the variable will cause the api service to use
# the default form the config YAMLs.
if couch_domain
  log "application server domain: #{domain}"

  env 'SERVER_DOMAIN' do
    value domain
    action :create
  end
else
  log 'application server domain: NA'

  env 'SERVER_DOMAIN' do
    action :delete
  end
end

# Restart the service to pull in the modified environment variable
windows_service node['server']['name'] do
  action :restart
end
