#!/bin/bash


HOST=$1
INDEX=$(echo $2 | cut -f1 -d'.')
OID="1.3.6.1.2.1.31.1.1.1.1.$INDEX"

#snmpwalk -v2c -c Gl0b4LL1N3s 10.255.97.70 1.3.6.1.2.1.31.1.1.1.1.4194312192
# IF-MIB::ifName.4194312192 = STRING: GPON 0/1/0
snmpwalk -Oqv -Ir -v2c -c qn31415926 $HOST $OID
