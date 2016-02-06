require 'serverspec'

set :backend, :cmd
set :os, family: 'windows'

describe 'CouchDB Server' do
  describe service('Apache CouchDB') do
    it { should be_installed }
    it { should be_enabled }
    it { should be_running }
  end

  describe port(5984) do
    it { should be_listening.with('tcp') }
  end

  describe file('C:\CouchDB\etc\couchdb\local.ini') do
    it { should be_file }
  end
end
