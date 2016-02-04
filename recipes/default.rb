#
# Cookbook Name:: btc-infrastructure
# Recipe:: default
#
# Copyright (c) 2015 The Authors, All Rights Reserved.

directory node['installers']['dir'] do
  action :create
end
