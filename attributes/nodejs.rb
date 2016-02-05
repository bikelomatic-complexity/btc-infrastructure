
nodejs_version = '4.2.1'
normal['nodejs']['version'] = nodejs_version

normal['nodejs']['msi'] = "node-v#{nodejs_version}-x64.msi"
normal['nodejs']['url'] = "https://nodejs.org/dist/v#{nodejs_version}"
normal['nodejs']['checksum'] = "e460a71ea9aa4d743387a20319042de203de837cb613be0737b6ca368480302d"
