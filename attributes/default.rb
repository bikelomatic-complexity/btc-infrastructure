
normal['installers']['dir'] = 'C:\Installers'
normal['server']['dir'] = 'C:\App-Server'

normal['git']['version'] = '2.7.0'
normal['git']['exe'] = -> (ver) {"Git-#{ver}-64-bit.exe"}
normal['git']['url'] = -> (ver) {"https://github.com/git-for-windows/git/releases/download/v#{ver}.windows.1"}
