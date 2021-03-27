#!/usr/bin/env python3
import sys
from zabbix_api import ZabbixAPI

argFiltro = sys.argv[1]
argHost = sys.argv[2]
username = "matheus"
password = "123mudar"

zapi = ZabbixAPI(server="http://localhost:81")
zapi.session.verify = False
zapi.login(username,password)

hosts = zapi.host.get({"output": ["hostid"], "filter": { "name": argHost }})
hostid = hosts[0]["hostid"]

#print (hostid)
if argFiltro in "triggers":
        argStatus = sys.argv[3]
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
        argStatus = sys.argv[3]
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


if argFiltro in "onuStatusPon":
        argPon    = sys.argv[3]
        argStatus = sys.argv[4]
        countOn = 0
        countOff = 0
        # pega os items de chave da gpon
        items = zapi.item.get({
                "output": ["name","lastvalue","key_"],
                "hostids": hostid, "search": { "key_": "huawei-get-pon.sh" } })
        for x in items:
                dbPon = x["lastvalue"]
                key = x["key_"]
                if dbPon in argPon:
                    #print(key)
                    dados = key.replace("huawei-get-pon.sh[{HOST.CONN},","")
                    dados = dados.replace("]","")
                    #print(dados)
                    items2 = zapi.item.get({
                        "output": ["name","lastvalue"],
                        "hostids": hostid, "search": { "key_": "1.3.6.1.4.1.2011.6.128.1.1.2.46.1.15.[" + dados + "]" } })
                    for x2 in items2:
                        status = float(x2["lastvalue"])
                        if (status == 1):
                            countOn += 1
                        else:
                            countOff += 1
                        #print(status)

        if (int(argStatus) == 1):
                print (countOn)
        else:
                print (countOff)

if argFiltro in "onuOfflineCause":
        argCause = int(sys.argv[3])
        count = 0
        # pega os items de chave da gpon
        items = zapi.item.get({
                "output": ["name","lastvalue","key_"],
                "hostids": hostid, "search": { "key_": "1.3.6.1.4.1.2011.6.128.1.1.2.46.1.15" } })
        for x in items:
                status = x["lastvalue"]
                key = x["key_"]
                if status == "2":
                    #print(key)
                    dados = key.replace("1.3.6.1.4.1.2011.6.128.1.1.2.46.1.15.[","")
                    dados = dados.replace("]","")
                    #print(dados)
                    items2 = zapi.item.get({
                        "output": ["name","lastvalue"],
                        "hostids": hostid, "search": { "key_": "1.3.6.1.4.1.2011.6.128.1.1.2.46.1.24.[" + dados + "]" } })
                    for x2 in items2:
                        downCause = int(x2["lastvalue"])
                        #print(downCause)
                        if (downCause == argCause):
                            count += 1
        print (count)


