#
# Cookbook Name:: btc-infrastructure
# Recipe:: nodejs
#
# Author:: Matt Waite
#
# Copyright 2016, Adventure Cycling Association

installers = node['installers']['dir']

node_url = node['nodejs']['url']
node_msi = node['nodejs']['msi']

git_url = node['git']['url']
git_exe = node['git']['exe']

remote_file "#{installers}/#{git_exe}" do
  source "#{git_url}/#{git_exe}"
  checksum 'edab3c7ee50cdcb66ac66b5f3b2e7ea7ce25c85ffc03e9602deffd8eb27e323e'
  action :create
end

powershell_script 'install-git' do
  # code <<-EOH
    # "#{installers}/#{git_exe} /SP /SILENT /NORESTART"
	# [Environment]::SetEnvironmentVariable("Path", $env:Path + ";C:/Program Files/Git/bin", [EnvironmentVariableTarget]::Machine)
  # EOH
  code <<-EOH
    #{installers}/#{git_exe} /SP /SILENT /NORESTART
  EOH
  action :run
  not_if "Test-Path C:\\Program Files\\Git"
end

remote_file "#{installers}/#{node_msi}" do
  source "#{node_url}/#{node_msi}"
  checksum 'e460a71ea9aa4d743387a20319042de203de837cb613be0737b6ca368480302d'
  action :create
end

windows_package "#{installers}/#{node_msi}" do
  action :install
end
