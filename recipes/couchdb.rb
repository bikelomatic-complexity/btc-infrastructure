
directory node.installers.dir

url = node.couchdb.url.(node.couchdb.version)
exe = node.couchdb.exe.(node.couchdb.version)

remote_file "#{node.installers.dir}/#{exe}" do
  source "#{url}/#{exe}"
  checksum '19060785d7ca9b7a6da9da48b8f7c791ebab2f7fabdab840969434b6e51e234a'
  action :create
end

home = node.couchdb.home

powershell_script 'install_couchdb' do
  # code "#{node.installers.dir}/#{exe} /SP /SILENT /NORESTART /DIR='#{home}'"
  code "#{node.installers.dir}/#{exe} /SP /SILENT /NORESTART /DIR='#{home}' /TASKS=''"
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

powershell_script 'install_couchdb_service' do
  code <<-EOH
    #{home}/erts-5.10.3/bin/erlsrv.exe add "Apache CouchDB" `
        -workdir "#{home}/bin"                              `
        -onfail restart_always                              `
        -args "-sasl errlog_type error -s couch +A 4 +W w"  `
        -comment "Apache CouchDB 1.6.1"                     `
        -i "Apache CouchDB"
  EOH
  action :run
  not_if "@(Get-Service 'Apache CouchDB').count -ge 1"
end

windows_service 'Apache CouchDB' do
  action :enable
end

windows_service 'Apache CouchDB' do
  action :start
end
