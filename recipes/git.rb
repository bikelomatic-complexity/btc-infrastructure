# btc_infrastructure -- Cookbook for the Bicycle Touring Companion
# Copyright (C) 2016 Adventure Cycling Association
#
# This file is part of btc_infrastructure.
#
# btc_infrastructure is free software: you can redistribute it and/or modify
# it under the terms of the Affero GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# btc_infrastructure is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# Affero GNU General Public License for more details.
#
# You should have received a copy of the Affero GNU General Public License
# along with btc_infrastructure.  If not, see <http://www.gnu.org/licenses/>.

git_url = node['git']['url']
git_exe = node['git']['exe']

file_cache_path = Chef::Config[:file_cache_path]

remote_file File.join(file_cache_path, git_exe) do
  source "#{git_url}/#{git_exe}"
  checksum node['git']['checksum']
  action :create
end

installer_script = File.join(file_cache_path, 'git.iss')

template installer_script do
  source 'git.iss.erb'
end

git_home = node['git']['home']

# Install Node.js to Program Files
windows_package node['git']['display_name'] do
  source File.join(file_cache_path, git_exe)
  options "/LOADINF='#{installer_script}'"
  action :install
end

# On some systems, the 64 bit installer sets an x86 path variable
# We do not want that!
windows_path 'C:\\Program Files (x86)\\Git\\bin' do
  action :remove
end

# Add Git's home directory to the Windows path, and to Ruby's ENV
windows_path "#{git_home}\\bin" do
  action [:remove, :add]
end
