require 'serverspec'

set :backend, :cmd
set :os, :family => 'windows'

describe "Nodejs Package" do

  # On Windows, the package name is the DisplayName in the registry
  describe package('Node.js') do
    it { should be_installed }
  end

end
