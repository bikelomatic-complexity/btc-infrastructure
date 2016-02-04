name             "btc-infrastructure"
maintainer       "Adventure Cycling Association"
maintainer_email "sk.kroh@gmail.com"
license          "all_rights"
description      "Installs and configures Bicycle Touring Companion"
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          "0.1.0"

depends          "netsh_firewall", ">= 0.3.2"
depends          "git", ">= 4.3.7"

supports         "windows"
