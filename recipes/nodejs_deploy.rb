#
# Cookbook Name:: btc-infrastructure
# Recipe:: nodejs
#
# Author:: Matt Waite
#
# Copyright 2016, Adventure Cycling Association

server_dir = node['server']['dir']
directory server_dir

# Powershell script to stop the app server, install updates, and then restart
powershell_script 'deploy' do
  code <<-EOH
    If (Test-Path "#{server_dir}/node-server") {
	  cd "#{server_dir}/node-server"
	  npm stop
	  git pull origin master
	  cd "#{server_dir}"
	} Else {
	  cd "#{server_dir}"
	  git clone git://github.com/bikelomatic-complexity/node-server.git
	}
	cd "#{server_dir}/node-server"
	npm install
	npm start
  EOH
  action :run
end

# That npm start will cause this script to not complete.
# We need to find a way to register and start the server as a windows service
