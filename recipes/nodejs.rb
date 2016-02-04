
directory node.installers.dir

node_url = node.nodejs.url.(node.nodejs.version)
node_msi = node.nodejs.msi.(node.nodejs.version)
git_url = node.git.url.(node.git.version)
git_exe = node.git.exe.(node.git.version)


remote_file "#{node.installers.dir}/#{git_exe}" do 
  source "#{git_url}/#{git_exe}"
  checksum 'edab3c7ee50cdcb66ac66b5f3b2e7ea7ce25c85ffc03e9602deffd8eb27e323e'
  action :create
end

powershell_script 'install-git' do
  code <<-EOH
    "#{node.installers.dir}/#{git_exe} /SP /SILENT /NORESTART"
	[Environment]::SetEnvironmentVariable("Path", $env:Path + ";C:/Program Files/Git/bin", [EnvironmentVariableTarget]::Machine)
  EOH
  action :run
end

remote_file "#{node.installers.dir}/#{node_msi}" do
  source "#{node_url}/#{node_msi}"
  checksum 'e460a71ea9aa4d743387a20319042de203de837cb613be0737b6ca368480302d'
  action :create
end

windows_package "#{node.installers.dir}/#{node_msi}" do
  action :install
end

