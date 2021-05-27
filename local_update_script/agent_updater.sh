#!/bin/bash
#
# local script to update the  checkmk_agent based on https://<SERVER>/<INSTANCE>_latest_deb_agent
#
#

# Variables
DLAGENT="" #download string for the agent
AGENT="/tmp/checkmk_agent.deb" #Agent locatin and filename
LINUX=$(cat /etc/issue | awk '{ print $1 }') # get the distribution name
INSTANCE="<INSTANCE>" # your monitoring instance
DLSERVER="<SERVER IP>" # Webserver to download the agent
DEBUG=0 # can be set to 1 default is 0

# check Linux Distribution
if [ $DEBUG -eq "1" ]; then echo $LINUX " - CRTL C for exit" && sleep 5; fi

# for Ubunut or Debian Systems
if [ $LINUX == "Ubuntu" ] || [ $LINUX == "Debian" ]
 then
    DLAGENT=$INSTANCE"_latest_deb_agent"
fi

# Download Agent
curl -s -k https://$DLSERVER/$DLAGENT -o $AGENT

# check the installed vesion of the agent
INSTALLEDAGENT=$(sudo apt-cache policy check-mk-agent | grep Installed | awk '{ print $2 }')
# check the client version that has been downloaded
REMOTEAGENT=$(dpkg-deb -f $AGENT Version )

# display versions for debug
if [ $DEBUG -eq "1" ]
 then
    echo $INSTALLEDAGENT" vs. "$REMOTEAGENT
fi

# compare versions
if [ "$INSTALLEDAGENT" !=  "$REMOTEAGENT" ]
 then
    if [ $DEBUG -eq "1" ]; then echo "NEW AGENT WILL BE INSTALLED - CRTL C for exit" && sleep 5; fi
    #launch installation
    sudo apt install $AGENT -y
fi

# remove downloadad agent
rm $AGENT
