# Cookbook Name:: btc-infrastructure
# Recipe:: nodejs
#
# Author:: Steven Kroh
#
# Copyright 2016, Adventure Cycling Association

installers = node['installers']['dir']

node_url = node['nodejs']['url']
node_msi = node['nodejs']['msi']

remote_file "#{installers}/#{node_msi}" do
  source "#{node_url}/#{node_msi}"
  checksum node['nodejs']['checksum']
  action :create
end

# Install Node.js to Program Files
windows_package node['nodejs']['display_name'] do
  source "#{installers}/#{node_msi}"
  action :install
end

# Add Node's home directory to the Windows path, and to Ruby's ENV
windows_path node['nodejs']['home'] do
  action [:remove, :add]
end

# Ensure Npm's home directory is global, and avoid %AppData%
powershell_script 'set_npm_prefix' do
  code "npm config set prefix #{node['nodejs']['npm']['home']}"
  action :run
end

# Add Npm's home directory to the Windows path, and to Ruby's ENV
windows_path node['nodejs']['npm']['home'] do
  action [:remove, :add]
end
