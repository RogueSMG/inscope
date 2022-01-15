if [[ -z $1 ]] || [[ -z $2 ]]
then
	echo "Usage: inscope.sh [DOMAIN_NAMES] [IN_SCOPE_IPS]"
	exit
fi
DOMAINS=$(cat $1)
SCOPE=$2
for i in $DOMAINS
do
	IP=$(dig +short $i)
	if [[ ! -z $IP ]] && grep -q "$IP" $SCOPE
	then
		echo $i
	fi
done
