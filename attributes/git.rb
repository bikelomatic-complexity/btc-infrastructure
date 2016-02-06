
git_version = '2.7.0'

#<> Version of Git to install
normal['git']['version'] = git_version
#<> DisplayName of Git in the windows registry
normal['git']['display_name'] = "Git version #{git_version}"
#<> Full url to the git install executable
normal['git']['url'] =  "https://github.com/git-for-windows/git/releases/download/v#{git_version}.windows.1/Git-#{git_version}-64-bit.exe"
#<> sha256 checksum of the git installer executable
normal['git']['checksum'] = "edab3c7ee50cdcb66ac66b5f3b2e7ea7ce25c85ffc03e9602deffd8eb27e323e"
