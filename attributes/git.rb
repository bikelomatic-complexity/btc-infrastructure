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

release = 'v2.7.1.windows.2'
git_version = '2.7.1.2'

hash = '956417448441e267a0ca601f47a2cd346e2d09589673060ae25d66628b2abc82'

normal['git']['version'] = git_version

# DisplayName of Git in the registry, for idempotency
normal['git']['display_name'] = "Git version #{git_version}"

url = "https://github.com/git-for-windows/git/releases/download/#{release}"
exe = "Git-#{git_version}-64-bit.exe"

normal['git']['url'] = url
normal['git']['exe'] = exe
normal['git']['checksum'] = hash
normal['git']['home'] = 'C:\\Program Files\\Git'
