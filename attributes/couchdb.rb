
couch_version = '1.6.1'
normal['couchdb']['version'] = couch_version

normal['couchdb']['url'] =  "https://www.apache.org/dist/couchdb/binary/win/#{couch_version}"
normal['couchdb']['exe'] = "setup-couchdb-#{couch_version}_R16B02.exe"
normal['couchdb']['checksum'] = '19060785d7ca9b7a6da9da48b8f7c791ebab2f7fabdab840969434b6e51e234a'

normal['couchdb']['home'] = 'C:\CouchDB'
normal['couchdb']['bind_address'] = '0.0.0.0'
normal['couchdb']['port'] = 5984
