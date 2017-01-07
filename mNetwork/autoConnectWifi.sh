#!/bin/bash -x

/usr/local/bin/gpio write 4 1

fAvailableNetworks="availableNetworks.list"
fWifiConf="/etc/wpa_supplicant/wpa_supplicant.conf"
wifiInterface="wlan0"

alreadyConnected=0

ifdown $wifiInterface
sleep 10
iwlist $wifiInterface scan | grep "ESSID:" | sed "s/ESSID:\"\(.*\)\"/\1/g" > $fAvailableNetworks

if [ -f $fAvailableNetworks ]
then
	while read network
	do
		set $network
		while read aNetwork
		do
			if [ "k$aNetwork" == "k$2" -a $alreadyConnected -eq 0 ]
			then
				ssid=$2
				pwd=$3
				echo "equal $aNetwork / $ssid / $pwd"
				cp $fWifiConf old.conf
				#ifconfig $fWifiConf down
				sed "s/\(ssid=\"\).*\(\"\)/\1$ssid\2/" old.conf | sed "s/\(psk=\"\).*\(\"\)/\1$pwd\2/" > $fWifiConf
				#ifdown $wifiInterface
				ifup $wifiInterface
				alreadyConnected=1
				/usr/local/bin/gpio write 4 0
			fi
		done < $fAvailableNetworks
	done < <(mysql -hlocalhost -udgidrone -ppassword dgidrone -e "SELECT * FROM wifiCode")
else
	echo "not available networks file"
fi
