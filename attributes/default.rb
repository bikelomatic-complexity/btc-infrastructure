normal['installers']['dir'] = 'C:\Installers'
normal['server']['dir'] = 'C:\App-Server'

normal['nodejs']['version'] = '4.2.1'
normal['nodejs']['msi'] = -> (ver) {"node-v#{ver}-x64.msi"}
normal['nodejs']['url'] = -> (ver) {"https://nodejs.org/dist/v#{ver}"}

normal['git']['version'] = '2.7.0'
normal['git']['exe'] = -> (ver) {"Git-#{ver}-64-bit.exe"}
normal['git']['url'] = -> (ver) {"https://github.com/git-for-windows/git/releases/download/v#{ver}.windows.1"}


normal['mongodb']['version'] = '3.0.7'
normal['mongodb']['msi'] = -> (ver) {"mongodb-win32-x86_64-2008plus-ssl-#{ver}-signed.msi"}
normal['mongodb']['url'] = -> (ver) {"http://downloads.mongodb.org/win32"}
normal['mongodb']['home'] = 'C:\mongodb'

normal['couchdb']['version'] = '1.6.1'
normal['couchdb']['exe'] = -> (ver) {"setup-couchdb-#{ver}_R16B02.exe"}
normal['couchdb']['url'] = -> (ver) {"https://www.apache.org/dist/couchdb/binary/win/#{ver}"}
normal['couchdb']['home'] = 'C:\CouchDB'
normal['couchdb']['bind_address'] = '0.0.0.0'
normal['couchdb']['port'] = 5984
