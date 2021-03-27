#!/usr/bin/env python3
# coding=utf-8
##############################
#     LUCAS ROCHA ABRAÃO     #
#   lucasrabraao@gmail.com   #
#  github: LucasRochaAbraao  #
#      ver: 1.0 13/3/20      #
##############################
 
import sys
from datetime import datetime
from snmp import py_snmp

def main():
    
    OLT, PON = sys.argv[1], sys.argv[2]

    status_all = py_snmp.status(OLT, 'qn31415926', PON)

    online = []
    for onu in status_all:
        if onu == 'online':
            online.append(onu)
    print(len(online))


if __name__ == '__main__':
    #main()
    with open("/usr/lib/zabbix/externalscripts/logs/logs", "a") as f:
        frase = list()
        for arg in sys.argv[1:]:
            frase.append(arg)
        f.write(f'{datetime.now().strftime("%d-%m-%y %H:%M:%S")} - {" ".join(frase)}\n==========================\n')

