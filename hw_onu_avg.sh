#!/bin/bash

olt_ip=$1
snmp_community=$2
pon_index=$3
oid=".1.3.6.1.4.1.2011.6.128.1.1.2.51.1.4"


cmd=$(timeout 15 2>/dev/null snmpbulkwalk -c$snmp_community -v2c $olt_ip .1.3.6.1.4.1.2011.6.128.1.1.2.51.1.4.$pon_index | awk -F ' ' '{print $4}' | sed -E 's/^-([1-9]|[1-8][0-9]|9[0-9]|[1-8][0-9]{2}|9[0-8][0-9]|99[0-9]|1[0-2][0-9]{2}|1300)$/ /g; s/2147483647/ /g' | awk 'NF' )
resultado_cmd=$(echo "$cmd" | paste -sd' '  | bc )
linhas_cmd=$(echo "$cmd" | wc -l )


if [[ -z "$resultado_cmd" ]]; then

	echo "0"

else

	echo $resultado_cmd / $linhas_cmd | bc

fi
