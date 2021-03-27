#!/usr/bin/python3
#########################################
#                                       #
# Author: CGR QUICKNET                  #
# Email: cgr@quick.com.br
#                                       #
#########################################
import sys
from bs4 import BeautifulSoup
import requests


response = requests.get("http://192.168.240.124")

bs = BeautifulSoup(response.text, 'html.parser')
temp = bs.find("div", {"class": "temp"})
hum = bs.find("div", {"class": "hum"})
    
if len(sys.argv) < 2:
    print("selecione TEMP ou HUM")
    sys.exit()
if sys.argv[1] == 'temp':
    print(int(float(temp.text)))
elif sys.argv[1] == 'humi':
    print(hum.text)
else:
    print(sys.argv[1:])

