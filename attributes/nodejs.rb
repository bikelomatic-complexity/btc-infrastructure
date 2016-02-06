
nodejs_version = '4.2.1'
# <> Version of Node.js to install
normal['nodejs']['version'] = nodejs_version

# <> Filename of the Node.js MSI
normal['nodejs']['msi'] = "node-v#{nodejs_version}-x64.msi"

# <> Base URL at which to find the Node.js MSI
normal['nodejs']['url'] = "https://nodejs.org/dist/v#{nodejs_version}"

hash = "e460a71ea9aa4d743387a20319042de203de837cb613be0737b6ca368480302d"

# <> sha256 checksum of the MSI
normal['nodejs']['checksum'] = hash
