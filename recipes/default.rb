#
# Cookbook Name:: btc-infrastructure
# Recipe:: couchdb
#
# Author:: Steven Kroh (<sk.kroh@gmail.com>)
#
# Copyright 2016, Adventure Cycling Association

=begin
#<
Ensures the directory at `['installers']['dir']` exists.
#>
=end

directory node['installers']['dir'] do
  action :create
end
