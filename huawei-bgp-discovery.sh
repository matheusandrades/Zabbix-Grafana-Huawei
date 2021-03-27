#!/bin/bash

DADOS_PEERS='
138.36.171.26,268775,MYZONE-V4
'

DADOS=`snmpwalk -v2c -On -c Gl0b4LL1N3s 201.131.247.1 1.3.6.1.4.1.2011.5.25.177.1.1.2.1.4 | sed 's/ = STRING: /#/g' | sed 's/"//g' | sed 's/1.3.6.1.4.1.2011.5.25.177.1.1.2.1.4.//g'`
SALTOS=0;
ARRAY=($DADOS)
LINHAS=${#ARRAY[@]}


echo "{"
echo "\"data\": ["
for i in $DADOS
do
        let "SALTOS++";
        INDEX=`echo $i | awk -F'#' '{ print $1 }'`
        PEER=`echo $i | awk -F'#' '{ print $2 }'`
        NOME=`echo "$DADOS_PEERS" | grep "$PEER," | awk -F  "," '{print $3}'`
#       echo "$INDEX - $PEER - $NOME"

        if [ $SALTOS -lt $LINHAS ]; then
		LINHA="{ \"{#SNMPINDEX}\":\"$INDEX\",\"{#NOME}\":\"$NOME ($PEER)\",\"{#PEER}\":\"$PEER\"},";
        else
		LINHA="{ \"{#SNMPINDEX}\":\"$INDEX\",\"{#NOME}\":\"$NOME ($PEER)\",\"{#PEER}\":\"$PEER\"}";
        fi
        echo "$LINHA"
done
echo "]"
echo "}"
