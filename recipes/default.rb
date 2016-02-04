#
# Cookbook Name:: btc-infrastructure
# Recipe:: couchdb
#
# Author:: Steven Kroh (<sk.kroh@gmail.com>)
#
# Copyright 2016, Adventure Cycling Association

directory node['installers']['dir'] do
  action :create
end
