
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
  code "#{node.installers.dir}/#{exe} /SP /SILENT /NORESTART /DIR='#{home}' /TASKS='service'"
  action :run
  not_if "Test-Path #{home}"
end

template "#{home}/etc/couchdb/local.ini" do
  source 'local.ini.erb'
end

netsh_firewall_rule 'Apache CouchDB' do
  action :allow
  description 'Allow HTTP connections to CouchDB on TCP port 5984'
  dir :in
  localport '5984'
  protocol :tcp
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
