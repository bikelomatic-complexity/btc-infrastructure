# Cookbook Name:: btc-infrastructure
# Recipe:: couchdb_bootstrap
#
# Author:: Steven Kroh (<sk.kroh@gmail.com>)
#
# Copyright 2016, Adventure Cycling Association

# <
# Bootstraps our running CouchDB instance with design documents and other
# settings
# >

# We need nodejs to run couchdb-bootstrap: it's an npm module
include_recipe 'btc_infrastructure::nodejs'

work = node['work']['dir']

# Create a work directory to extract our CouchDB config structure to
directory work

remote_directory "#{work}/couchdb" do
  source 'couchdb'
  action :create
end

# Install the couchdb-bootstrap npm module globally
# TODO: Figure out better npm path solution.
# The not_if should really just be `Get-Command couchdb-bootstrap`
powershell_script 'install_couchdb_bootstrap' do
  code 'npm install -g --silent couchdb-bootstrap'
  cwd "#{work}/couchdb"
  action :run
  not_if 'Get-Command couchdb-bootstrap'
end

admin = node['admin_users'][0]
username = admin['username']
password = admin['password']

port = node['couchdb']['port']

# Run couchdb-bootstrap on our folder structure.
# TODO: Figure out better npm path solution
powershell_script 'bootstrap' do
  code "couchdb-bootstrap http://#{username}:#{password}@localhost:#{port}"
  cwd "#{work}/couchdb"
  action :run
end
