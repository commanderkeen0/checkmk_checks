### Installscript for Windows check_mk Windows Agent
### Adding needed Firewall rule
### 
### 
#

# Variables
$PATH = "C:\tmp"
$INSTANCE = "<INSTANCE>"
$MONITORINGHOST = "<SERVER IP / FQDN>"

# Check if download path for the agent exists
If(!(test-path $PATH)){      New-Item -ItemType Directory -Force -Path $PATH}

### dowload CheckMK Agent from Monitoring Server
Write-Host -ForegroundColor Green "[1/4] Download CheckMK Agent from $MONITORINGHOST"
Invoke-WebRequest http://$MONITORINGHOST/$INSTANCE/check_mk/agents/windows/check_mk_agent.msi -OutFile $PATH\check_mk_agent.msi

### install CheckMK Agent
Write-Host -ForegroundColor Green "[2/4] install CheckMK agent"
Start-Process msiexec.exe -Wait -ArgumentList "/i $PATH\check_mk_agent.msi /qn /norestart"

### Firewall Regeln erstellen / aktivieren
# CheckMK Agent Regel
Write-Host -ForegroundColor Green "[3/4] create firewall rule for CheckMK agent"
New-NetFirewallRule -Name check_mk -DisplayName "Check_MK Monitoring Agent" -Enabled True -Direction Inbound -Profile Domain,Private,Public -Protocol TCP -LocalPort 6556 -Program "%ProgramFiles% (x86)\checkmk\service\check_mk_agent.exe" -RemoteAddress $MONITORINGHOST
# allow ICMPv4 for all profiles 
Write-Host -ForegroundColor Green "[4/4] active ICMP on firewall for all profiles"
Get-NetFirewallRule -Name FPS-ICMP4-ERQ-In | Enable-NetFirewallRule
Set-NetFirewallRule -name FPS-ICMP4-ERQ-In -Profile Domain,Private,Public
# End
Write-Host ""
Write-Host -ForegroundColor Green "All steps done !"
