
<powershell>
$LogDir= "C:\Users\Administrator\"
$ProvisioningLog= "$LogDir\testing.log"
Function LogWrite
{
  Param ([string]$logstring)
  Add-content $ProvisioningLog -value $logstring -PassThru
}
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope LocalMachine -Force
LogWrite "execution policy is set"
Configure-SMRemoting.exe -enable
LogWrite "remoting enabled"
Enable-PSRemoting -force
LogWrite "ps remoting enabled"
netsh advfirewall set allprofiles state off
cscript C:\Windows\System32\Scregedit.wsf /ar 0
Get-Service SysMain,Spooler | Stop-service -PassThru | Set-Service -StartUpType Disabled
LogWrite "sys spool set"
Get-Service Themes | Stop-service -PassThru | Set-Service -StartUpType Disabled
LogWrite "themes set"
w32tm /config /manualpeerlist:time.suntrust.com /syncfromflags:MANUAL
LogWrite "configuring time"
get-windowsfeature | where installed | get-bpamodel -ea silentlycontinue | Invoke-BpaModel
LogWrite "bpa installed"
(Get-WmiObject -class "Win32_TSGeneralSetting" -Namespace root\cimv2\terminalservices -Filter "TerminalName='RDP-tcp'").SetUserAuthenticationRequired(1)
LogWrite "last command"
(Get-WmiObject -class "Win32_TSGeneralSetting" -Namespace root\cimv2\terminalservices -Filter "TerminalName='RDP-tcp'").UserAuthenticationRequired
LogWrite "LAST COMMAND"
iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
LogWrite "installing chocolatey...."
choco install 7zip -y
LogWrite "installing 7zip...."
refreshenv
choco install python -y
LogWrite "installing python..."
refreshenv
choco install unzip -y
LogWrite "installing unzip...."
refreshenv
Invoke-WebRequest -Uri https://s3.amazonaws.com/aws-cli/AWSCLI64.msi -OutFile C:\Users\Administrator\AWS.msi
Start-Process -FilePath C:\Users\Administrator\AWS.msi -ArgumentList /quiet -PassThru -Wait
refreshenv
LogWrite "installing AWSCLI...."
Invoke-WebRequest -Uri https://s3.amazonaws.com/ec2-downloads-windows/EC2Config/EC2Install.zip -OutFile C:\Users\Ec2Install.zip
Add-Type -AssemblyName System.IO.Compression.FileSystem
function Unzip
{
  param([string]$zipfile, [string]$outpath)
  [System.IO.Compression.ZipFile]::ExtractToDirectory($zipfile, $outpath)
}
Unzip "C:\Users\Ec2Install.zip" "C:\Users\"
LogWrite "installing Ec2Config and SSM ....."
Start-Process -FilePath C:\Users\Ec2Install.exe -ArgumentList /s -PassThru -Wait
Restart-Service Ec2Config
Restart-Service AmazonSSMAgent
LogWrite "restarting services....."
Invoke-WebRequest -Uri https://d1wk0tztpsntt1.cloudfront.net/windows/installer/latest/AWSAgentInstall.exe -OutFile C:\Users\Administrator\AWSAgentInstall.exe
Start-Process -FilePath C:\Users\Administrator\AWSAgentInstall.exe -ArgumentList /s -PassThru -Wait
Restart-Service AWSAgent
LogWrite "installing and restarting AWS inspector agent......"
Install-WindowsFeature -Name FileAndStorage-Services,File-Services,FS-FileServer,FS-Data-Deduplication,FS-Resource-Manager,FS-VSS-Agent,RSAT-File-Services,RSAT-FSRM-Mgmt,RSAT-CoreFile-Mgmt,Windows-Server-backup
LogWrite "executed long command restarting..."
Restart-Computer
</powershell>