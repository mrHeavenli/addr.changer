#!/bin/sh


switch_mode()
{
	# Mode = 1 = Managed, Mode = 2 = Monitor
	# adapter=$1 mode=$2	
	# Has to be turned off before changing mode
	ifconfig $1 down

	# Changing mode
	if [ $2 = 1 ]
	then
		iwconfig $1 mode managed
	elif [ $2 = 2 ]
	then
		iwconfig $1 mode monitor

	fi

	# Turning it back on again
	ifconfig $1 up

}

change_hostname()
{
	echo $1 > /etc/hostname
	echo Reboot for change to take effect
}

change_mac()
{
	ip link set $1 down 
	ip link set $1 address $2
	ip link set $1 up
}

if [ $1 = "--help" ]
then
	cat usage.txt
elif [ $1 = "--interfaces" ]
then
	echo Interfaces:
	for interface in $(ip link show | grep --colour=never -Eo "[0-9]+: \w{2,}")
	do
		echo $interface | grep --colour=never -Eo "[a-z0-9]{2,}"
	done
elif [ $1 = "--mac" ]
then
	change_mac $2 $3
elif [ $1 = "--hostname" ]
then
	change_hostname $2
elif [ $1 = "--mode" ]
then
	switch_mode $2 $3
fi










