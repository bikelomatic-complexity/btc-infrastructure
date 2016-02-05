require 'serverspec'

set :backend, :cmd
set :os, :family => 'windows'

def fwregex(key, val)
  return /#{key}:\s*#{val}/
end

describe 'Database Server Firewall' do

  describe command("netsh advfirewall firewall show rule 'Apache CouchDB'") do
    its(:exit_status) { should eq 0 }
    its(:stdout) { should match fwregex('Enabled',    'Yes') }
    its(:stdout) { should match fwregex('Direction',  'In') }
    its(:stdout) { should match fwregex('LocalIP',    'Any') }
    its(:stdout) { should match fwregex('RemoteIP',   'Any') }
    its(:stdout) { should match fwregex('RemoteIP',   'Any') }
    its(:stdout) { should match fwregex('Protocol',   'TCP') }
    its(:stdout) { should match fwregex('LocalPort',  '5984') }
    its(:stdout) { should match fwregex('RemotePort', 'Any') }
    its(:stdout) { should match fwregex('Action',     'Allow') }
  end

end
