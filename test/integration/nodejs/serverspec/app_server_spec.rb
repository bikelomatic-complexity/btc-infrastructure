require 'serverspec'

set :backend, :cmd
set :os, family: 'windows'

describe 'App Server' do
  describe service('btc-app-server') do
    it { should be_installed }
    it { should be_enabled }
    it { should be_running }
  end

  describe port(80) do
    it { should be_listening.with('tcp') }
  end
end

def fwregex(key, val)
  /#{key}:\s*#{val}/
end

netsh = 'netsh advfirewall firewall show rule'

describe 'App Server Firewall' do
  describe command("#{netsh} 'Node.js App Server'") do
    its(:exit_status) { should eq 0 }
    its(:stdout) { should match fwregex('Enabled',    'Yes') }
    its(:stdout) { should match fwregex('Direction',  'In') }
    its(:stdout) { should match fwregex('LocalIP',    'Any') }
    its(:stdout) { should match fwregex('RemoteIP',   'Any') }
    its(:stdout) { should match fwregex('RemoteIP',   'Any') }
    its(:stdout) { should match fwregex('Protocol',   'TCP') }
    its(:stdout) { should match fwregex('LocalPort',  '80') }
    its(:stdout) { should match fwregex('RemotePort', 'Any') }
    its(:stdout) { should match fwregex('Action',     'Allow') }
  end
end
