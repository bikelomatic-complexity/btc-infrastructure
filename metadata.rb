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

name             'btc_infrastructure'
maintainer       'Adventure Cycling Association'
maintainer_email 'sk.kroh@gmail.com'
license          'AGPL v3'
description      'Installs and configures Bicycle Touring Companion'
version          '0.4.0'

source_url       'https://github.com/bikelomatic-complexity/btc-infrastructure'
issues_url       'https://github.com/bikelomatic-complexity/btc-infrastructure/issues'

depends          'netsh_firewall', '>= 0.3.2'
depends          'nssm', '~> 1.2.0'

supports         'windows'
