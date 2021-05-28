# Scope

This agent will not replace the enterprise capability. It will only enhance the usage of the RAW edition

# Files

## Server: agent_link_updater.sh
This script will be established as a cronjob on the monitoring server. 
It generates a symbolic link on the HTMLROOT folder with a instance suffix and a prefix depending on the version

currenlty links are generated forthe following packets: deb, rpm and msi (32bit) 


## Client Linux: agent_updater.sh
This script download the deb / rpm file to /tmp and will compare the installed version vs the downloaded one an install if a change is found

ToDo:
Work in progress: RPM is not implemented jet  



## Client Windows: agent_updater.ps1
This script downloads the agent and installs it. Further it opens the firewall rules for the windows based firewall.

ToDo:
WORK in progess
