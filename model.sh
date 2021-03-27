#!/bin/bash

ip=$1
community=$2
fabricante=$3
timeout='10'
exec 2>/dev/null ## Jogando mensagens de erro para o limbo

case $fabricante in
        'Mikrotik')
                cmd=$(timeout 10 snmpget -v2c -c$community $ip 1.3.6.1.2.1.1.1.0 | awk -F ' ' '{$1=$2=$3=""; print $0}')
                if [[ -z "$cmd" ]]; then
                        echo 'Modelo Desconhecido'
                else
                        echo $cmd
                fi
                ;;
        'Radio Ubiquiti')
                snmpwalk=$(timeout 10 snmpwalk -c $community -Cc -v1 $ip iso.2.840.10036.3.1.2.1.3)
                resultado=$(echo "$snmpwalk" | awk -F ":" '/"/{print $2}' | sed 's/"//g'| head -n 1)
                airfiber_snmpwalk=$(timeout 10 snmpwalk -c $community -Cc -v1 $ip .1.3.6.1.4.1.41112.1.3.2.1.1.1)
                if [[ -n "$airfiber_snmpwalk" ]] && [[ $airfiber_snmpwalk != "End of MIB"  ]]; then
                        echo "AirFiber"
                else
                        if [[ -z "$resultado" ]]; then
                                echo "Modelo Desconhecido"
                        else
                                echo $resultado
                        fi
                fi

                ;;
        'Monitoramento Externo' )echo "Monitoramento Externo" ;;
        'Switch Cisco')
                snmpwalk=$(snmpwalk -c $community -v2c $ip 1.3.6.1.2.1.47.1.1.1.1.13 | grep STRING | awk -F ":" '/"/{print $4}' | sed 's/"//g' | tr -d '"')
                matriz=( $snmpwalk )
                resultado=""
                for i in "${matriz[@]}"
                        do
                                if [[ $i =~ CISCO.*|SG500.*|WS.*|^ME|^N3K-C3064PQ ]]
                                then
                                        resultado=$i
                                fi
                        done
                echo $resultado
                ;;
        'Switch Datacom') cmd=$(timeout 10 snmpwalk -v2c -c $community $ip sysDescr | awk -F ' ' '{$1=$2=$3=""; print $0}' | tr -d '"')
                if [[ -z "$cmd" ]]; then
                        echo 'Modelo Desconhecido'
                else
                        echo $cmd
                fi
                ;;
        'Router Cisco') cmd=$(timeout 10 snmpget -v2c -c$community $ip .1.3.6.1.2.1.47.1.1.1.1.13.1 | awk -F ' ' '{$1=$2=$3=""; print $0}' | tr -d '"') 
                if [[ -z "$cmd" ]]; then
                        echo 'Modelo Desconhecido'
                else
                        echo $cmd
                fi
                ;;
        'Monitoramento Link')echo "Monitoramento Link" ;;
        'Monitoramento Linux')echo "Monitoramento Linux" ;;
        'Monitoramento VMWare')echo "Monitoramento VMWare" ;;
           'Zabbix Proxy') echo "Ubuntu Server 16.04" ;;
           'SwitchOS')
                cmd=$(timeout 10 snmpget -v1 -c$community $ip sysDescr.0 | awk -F ' ' '{$1=$2=$3=""; print $0}')
                if [[ -z "$cmd" ]]; then
                        echo 'Modelo Desconhecido'
                else
                        echo $cmd
                fi
                ;;
        'Switch Intelbras SG')
                cmd=$(timeout 10 snmpget -v2c -c$community $ip .1.3.6.1.2.1.16.19.3.0 | awk -F ' ' '{$1=$2=$3=""; print $0}' | tr -d '"')
                if [[ -z "$cmd" ]]; then
                        echo 'Modelo Desconhecido'
                else
                        echo $cmd
                fi
                ;;
        'Asustor')
                        cmd=$(timeout 10 snmpget -v2c -c$community $ip .1.3.6.1.4.1.44738.2.1.0 | awk -F ' ' '{$1=$2=$3=""; print $0}')
                        if [[ -z "$cmd" ]]; then
                        echo 'Modelo Desconhecido'
                else
                        echo $cmd
                fi
                ;;
        'Switch Huawei')
                cmd=$(timeout 10 snmpget -v2c -c$community $ip .1.3.6.1.2.1.47.1.1.1.1.7.67108867 | awk -F ' ' '{$1=$2=$3=""; print $0}' | tr -d '"')
                if [[ -z "$cmd" ]]; then
                        echo 'Modelo Desconhecido'
                else
                        echo $cmd
                fi
                ;;


        'NE20') cmd=$(timeout 10 snmpget -v2c -c$community $ip .1.3.6.1.4.1.2011.6.3.11.4.0 | awk -F ' ' '{$1=$2=$3=""; print $0}' | tr -d '"')
                if [[ -z "$cmd" ]]; then
                        echo 'Modelo Desconhecido'
                else
                        echo $cmd
                fi
                ;;
                
    'Edgeswitch') cmd=$(timeout 10 snmpget -v2c -c$community $ip .1.3.6.1.4.1.4413.1.1.1.1.1.2.0 | awk -F ' ' '{$1=$2=$3=""; print $0}' | tr -d '"')
                if [[ -z "$cmd" ]]; then
                        echo 'Modelo Desconhecido'
                else
                        echo $cmd
                fi
                ;;
       

esac
