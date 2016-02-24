name             'btc-infrastructure'
maintainer       'Adventure Cycling Association'
maintainer_email 'sk.kroh@gmail.com'
license          'AGPL v3'
description      'Installs and configures Bicycle Touring Companion'
version          '0.3.4'

source_url       'https://github.com/bikelomatic-complexity/btc-infrastructure'
issues_url       'https://github.com/bikelomatic-complexity/btc-infrastructure/issues'

depends          'netsh_firewall', '>= 0.3.2'
depends          'nssm', '~> 1.2.0'

supports         'windows'
