#/bin/bash
#
# read the site list and obtain the installed version
# this script is needed on the monitoring server
#
#


HTMLROOT="/var/www/html"
DEBAGENTPREFIX="latest_deb_agent"
RPMAGENTPREFIX="latest_rpm_agent"

# read the installed instances
IFS=', ' read -r -a array <<< $(omd sites -b)


# check each site for the currently installed version
for element in "${array[@]}"
 do
    # get the instance version
    VERSION=$(omd sites | grep $element | awk '{ print $2 }')

    # get the full path for thy symbolic link packet
    DEB=$(ls -1 /opt/omd/versions/$VERSION/share/check_mk/agents/*.deb)
    ln -sf $DEB $HTMLROOT/$element"_"$DEBAGENTPREFIX

    # get the full path for the symbolic link for RPM packet
    RPM=$(ls -1 /opt/omd/versions/$VERSION/share/check_mk/agents/*.rpm)
    ln -sf $RPM $HTMLROOT/$element"_"$RPMAGENTPREFIX

 done
