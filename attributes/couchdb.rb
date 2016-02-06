
couch_version = '1.6.1'

# <> The version of CouchDB to install
normal['couchdb']['version'] = couch_version

# <> The base url at which to obtain the Inno Setup installer for CouchDB.
normal['couchdb']['url'] = <<-EOH
https://www.apache.org/dist/couchdb/binary/win/#{couch_version}
EOH

# <> The name of the Inno Setup installer for CouchDB.
normal['couchdb']['exe'] = "setup-couchdb-#{couch_version}_R16B02.exe"

# <> The sha256 checksum of the installer to download.
normal['couchdb']['checksum'] = <<-EOH
19060785d7ca9b7a6da9da48b8f7c791ebab2f7fabdab840969434b6e51e234a
EOH

# <> The directory at which to install CouchDB.
normal['couchdb']['home'] = 'C:\CouchDB'

# <> Defines the IP address by which CouchDB will be accessible.
normal['couchdb']['bind_address'] = '0.0.0.0'

# <> Defines the IP address by which CouchDB will be accessible.
normal['couchdb']['port'] = 5984
