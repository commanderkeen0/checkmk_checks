#/bin/bash


# get array with all jails
IFS=', ' read -r -a array <<< $(sudo fail2ban-client status | grep "Jail list:" | sed 's/ //g' | awk -F " " '{ print $2}')

echo "<<<fail2ban_banned>>>"

for element in "${array[@]}"
do
    BANNED=$(sudo fail2ban-client status $element | grep "Currently banned:" | awk '{ print $NF }')
    echo "$element $BANNED"
done
