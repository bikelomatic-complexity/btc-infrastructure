require 'serverspec'

set :backend, :cmd
set :os, family: 'windows'

describe 'Git Version Control System' do
  # On Windows, the package name is the DisplayName in the registry
  describe package('Git version 2.7.0') do
    it { should be_installed }
  end
end
