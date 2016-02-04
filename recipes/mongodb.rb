
directory node.installers.dir

url = node.mongodb.url.(node.mongodb.version)
msi = node.mongodb.msi.(node.mongodb.version)

remote_file "#{node.installers.dir}/#{msi}" do
  source "#{url}/#{msi}"
  checksum '4677381cb53fb4b872e1fe0fce9161d80e1be53192bfdbf4d1cc20623adebb83'
  action :create
end

directory node.mongodb.home

windows_package "#{node.installers.dir}/#{msi}" do
  options "INSTALLLOCATION=\"#{node.mongodb.home}\""
  action :install
end
