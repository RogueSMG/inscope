#!/bin/bash

if [[ -z $1 ]] || [[ -z $2 ]]
then
	echo "Usage: inscope.sh [DOMAIN_NAMES] [Synack-Scope-txt-file.txt]"
	exit
fi
nmap -sL -n -iL $2 | awk '/Nmap scan report/{print $NF}' >> all_ips_scope.txt
DOMAINS=$(cat $1)
SCOPE=all_ips_scope.txt
for i in $DOMAINS
do
	IP=$(dig +short $i)
	if [[ ! -z $IP ]] && grep -q "$IP" $SCOPE
	then
		echo $i | anew inscope_domains.txt
	fi
done
