#!/bin/bash
ip=$1
community=$2

cmd=$(timeout 15 snmpwalk -c $community -v2c $ip 1.3.6.1.4.1.2011.6.128.1.1.2.21.1.16 | awk -F ' ' '{print $4}' | paste -sd+ | bc)

if [[ -z "$cmd" ]]; then

echo "0"

else

echo $cmd

fi
