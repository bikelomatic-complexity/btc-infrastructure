
directory node.installers.dir

url = node.couchdb.url.(node.couchdb.version)
exe = node.couchdb.exe.(node.couchdb.version)

remote_file "#{node.installers.dir}/#{exe}" do
  source "#{url}/#{exe}"
  checksum '19060785d7ca9b7a6da9da48b8f7c791ebab2f7fabdab840969434b6e51e234a'
  action :create
end

home = node.couchdb.home

powershell_script 'install-couchdb' do
  code "C:/Installers/#{exe} /SP /SILENT /NORESTART /DIR='#{home}' /TASKS='service'"
  action :run
  not_if "Test-Path #{home}"
end

template "#{home}/etc/couchdb/local.ini" do
  source 'local.ini.erb'
end

# The contents of this ini file override default.ini in the same directory
# file "#{home}/etc/couchdb/local.ini" do
#   # We need to find a way to auto generate the uuid
#   content <<-EOH
#     [couchdb]
#     uuid = 68ec73a234ac7e076744ee6732a47320
#
#     [httpd]
#     port = 5984
#     bind_address = 0.0.0.0
#   EOH
# end

powershell_script 'open-couchport' do
  code "netsh advfirewall firewall add rule name=couchport dir=in action=allow localport=5984 protocol=TCP"
  action :run
  not_if "netsh advfirewall firewall show rule name=couchport"
end

powershell_script 'start-couchdb' do
  code <<-EOH
    net.exe start 'Apache CouchDB'
  EOH
  action :run
  not_if <<-EOH
    $count = Get-Service 'Apache CouchDB' | Where-Object {$_.status -eq 'Running'} | measure
    $realCount = $count.Count
    $realCount -gt 0
  EOH
end
