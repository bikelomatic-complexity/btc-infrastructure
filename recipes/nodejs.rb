#
# Cookbook Name:: btc-infrastructure
# Recipe:: nodejs
#
# Author:: Matt Waite
#
# Copyright 2016, Adventure Cycling Association

installers = node['installers']['dir']

include_recipe "git::windows"

node_url = node['nodejs']['url']
node_msi = node['nodejs']['msi']

remote_file "#{installers}/#{node_msi}" do
  source "#{node_url}/#{node_msi}"
  checksum node['nodejs']['checksum']
  action :create
end

windows_package "Node.js" do
  source "#{installers}/#{node_msi}"
  action :install
end
