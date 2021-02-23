# Zabbix-Grafana


##Olá hoje venho trazer pra vocês uma solução de tratar OID´s que contem "sub-index", neste exemplo vamos consultar o total de ONU online por PON de uma OLT HUAWEI que por padrão não existe 1 só oid que retorne este valor total. Como iremos realizar isso?



###1° passo: Faça o download dos templates que disponibilizei no repositorio, feito isso importe para o ZABBIX e para o GRAFANA, depois de importa os templates, devemos experar retornar os valores no zabbix e depois partimos para o grafana.


##2° passo: Precisamos consultar a biblioteca de index de determinada PON, para isso vamos o snmpwalk com o oid iso.3.6.1.2.1.31.1.1.1.1, ele ira nos retorna algo semelhante : 

IF-MIB::ifName.4194328576 = STRING: GPON 0/3/0
IF-MIB::ifName.4194328832 = STRING: GPON 0/3/1
IF-MIB::ifName.4194329088 = STRING: GPON 0/3/2
IF-MIB::ifName.4194329344 = STRING: GPON 0/3/3
IF-MIB::ifName.4194329600 = STRING: GPON 0/3/4
IF-MIB::ifName.4194329856 = STRING: GPON 0/3/5
IF-MIB::ifName.4194330112 = STRING: GPON 0/3/6
IF-MIB::ifName.4194330368 = STRING: GPON 0/3/7
IF-MIB::ifName.4194330624 = STRING: GPON 0/3/8
IF-MIB::ifName.4194330880 = STRING: GPON 0/3/9
IF-MIB::ifName.4194331136 = STRING: GPON 0/3/10
IF-MIB::ifName.4194331392 = STRING: GPON 0/3/11
IF-MIB::ifName.4194331648 = STRING: GPON 0/3/12
IF-MIB::ifName.4194331904 = STRING: GPON 0/3/13
IF-MIB::ifName.4194332160 = STRING: GPON 0/3/14
IF-MIB::ifName.4194332416 = STRING: GPON 0/3/15

depois disso precisamos separar todos os index desse snmp exempo : (4194328576 = GPON 0/3/0), vamos ultilar somente a informação do index que é onde q vemos que o numero 4194328576 é referente a PON 0/3/0, no template que disponibilizei ja existem algumas criadas entao vocês só precisam adicionar de acordo com sua demanda. Tambem ja deixei disponibilizado uma "biblioteca" de index porem só vai da pon 0/1/x ate a 0/7/x.


##3° passo: Depois que ja identificamos todos os index com suas determinadas PON´s nos vamos para o grafana onde iremos personalizar de acordo com nossa demanda, por default eu deixei somente a gpon 0/3/0 ate a 0/3/15, mas vocês podem adicionar com sua demanda, para fazer isso você só vai replicar o painel e trocar o index na parte de ITENS para seu respectivo index da PON. no grafana eu adicionei algumas fuctions onde eu retiro todo resultado que é = 2 (OFFLINE) e só deixo oq for respectivo = 1 (ONLINE) depois disso agrupei em um grupo q faz a media dentro de 5 minutos e soma este valor.








