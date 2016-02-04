directory node.server.dir

# Powershell script to stop the app server, install updates, and then restart
powershell_script 'deploy' do
  code <<-EOH
    If (Test-Path "#{node.server.dir}/node-server") {
	  cd "#{node.server.dir}/node-server"
	  npm stop
	  git pull origin master
	  cd "#{node.server.dir}"
	} Else {
	  cd "#{node.server.dir}"
	  git clone git://github.com/bikelomatic-complexity/node-server.git
	}
	cd "#{node.server.dir}/node-server"
	npm install
	npm start
  EOH
  action :run
end

# That npm start will cause this script to not complete.
# We need to find a way to register and start the server as a windows service

