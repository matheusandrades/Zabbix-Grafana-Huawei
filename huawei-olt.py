#!/usr/bin/env python3
import sys
from zabbix_api import ZabbixAPI

argFiltro = sys.argv[1]
argHost = sys.argv[2]
argStatus = sys.argv[3]
username = "matheus"
password = "123mudar"

zapi = ZabbixAPI(server="http://localhost:81")
zapi.session.verify = False
zapi.login(username,password)

hosts = zapi.host.get({"output": ["hostid"], "filter": { "name": argHost }})
hostid = hosts[0]["hostid"]

#print (hostid)
if argFiltro in "triggers":
        triggers = zapi.trigger.get ({
                "output": ["triggerid","description", "lastchange"],
                "selectHosts": ["hostid", "host"],
                "filter": {"value":1, "hostid": hostid }
        })
        count = 0
        for y in triggers:
                nome_host = y["hosts"][0]["host"]
                #print (nome_host, "- ", y["description"])
                if argStatus in y["description"]:
                        count += 1
        print (count)


if argFiltro in "items":
        items = zapi.item.get({
                "output": ["name","lastvalue"],
                "hostids": hostid, "search": { "key_": "1.3.6.1.4.1.2011.6.128.1.1.2.46.1.15" } })
        countOn = 0
        countOff = 0

        for x in items:
                status = float(x["lastvalue"])
                if (status == 1):
                        countOn += 1
                else:
                        countOff += 1
        if (int(argStatus) == 1):
                print (countOn)
        else:
                print (countOff)
