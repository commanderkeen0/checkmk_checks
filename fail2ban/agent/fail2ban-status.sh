#/bin/bash
#
# fail2ban systemctl status
#

echo "<<<fail2ban_status>>>"

# check for status
STATUS=$(systemctl status fail2ban.service | grep "Active" | awk '{print $2"-"$3 }'| sed -e 's/(//g' | sed -e 's/)//g')
echo $STATUS 
