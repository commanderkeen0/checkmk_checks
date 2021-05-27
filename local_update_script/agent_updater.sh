#!/bin/bash
#
# local script to update the  checkmk_agent based on https://<SERVER>/<INSTANCE>_latest_deb_agent
#
#

# Variables
DLAGENT="" #download string for the agent
AGENT="checkmk_agent.deb" #
LINUX=$(cat /etc/issue | awk '{ print $1 }')
INSTANCE="INSTANCE"
DLSERVER="192.168.0.100"

# for Ubunut Systems
if [ $LINUX == "Ubuntu" ] || [ OR $LINUX == "Debian" ]
 then
    DLAGENT=$INSTANCE"_latest_deb_agent"

fi

curl -s -k https://$DLSERVER/$DLAGENT -o $AGENT

INSTALLEDAGENT=$(sudo apt-cache policy check-mk-agent | grep Installed | awk '{ print $2 }')
REMOTEAGENT=$(dpkg-deb -f ./$AGENT Version )


#echo $INSTALLEDAGENT" vs. "$REMOTEAGENT

if [ "$INSTALLEDAGENT" !=  "$REMOTEAGENT" ]
 then
    echo "unequal"
    sudo apt install ./$AGENT -y
fi
