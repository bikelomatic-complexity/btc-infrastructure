
nodejs_version = '4.2.1'
normal['nodejs']['version'] = nodejs_version

normal['nodejs']['msi'] = "node-v#{nodejs_version}-x64.msi"
normal['nodejs']['url'] = "https://nodejs.org/dist/v#{nodejs_version}"
