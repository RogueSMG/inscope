#!/bin/bash

nmap -sL -n -iL ips.txt | awk '/Nmap scan report/{print $NF}' >> all_ips_scope.txt

if [[ -z $1 ]]
then
	echo "Usage: inscope.sh [DOMAIN_NAMES]"
	exit
fi
DOMAINS=$(cat $1)
SCOPE=all_ips_scope.txt
for i in $DOMAINS
do
	IP=$(dig +short $i)
	if [[ ! -z $IP ]] && grep -q "$IP" $SCOPE
	then
		echo $i
	fi
done
