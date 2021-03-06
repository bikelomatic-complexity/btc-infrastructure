<powershell>
  $logfile="C:\\Program Files\\Amazon\\Ec2ConfigService\\Logs\\kitchen-ec2.log"
  #PS Remoting and & winrm.cmd basic config
  Set-ExecutionPolicy Unrestricted
  Enable-PSRemoting -Force -SkipNetworkProfileCheck
  & winrm.cmd set winrm/config '@{MaxTimeoutms="1800000"}' >> $logfile
  & winrm.cmd set winrm/config/winrs '@{MaxMemoryPerShellMB="1024"}' >> $logfile
  & winrm.cmd set winrm/config/winrs '@{MaxShellsPerUser="50"}' >> $logfile
  #Server settings - support username/password login
  & winrm.cmd set winrm/config/service/auth '@{Basic="true"}' >> $logfile
  & winrm.cmd set winrm/config/service '@{AllowUnencrypted="true"}' >> $logfile
  & winrm.cmd set winrm/config/winrs '@{MaxMemoryPerShellMB="1024"}' >> $logfile
  #Firewall Config
  & netsh advfirewall firewall set rule name="Windows Remote Management (HTTP-In)" profile=public protocol=tcp localport=5985 remoteip=localsubnet new remoteip=any  >> $logfile
  #{custom_admin_script}
</powershell>
