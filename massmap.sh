#!/bin/bash

if [ $# -eq 0 ]
  then
    echo "USAGE: ./massmap 10.10.10.10 /path/to/save_files"
    exit 0
fi


ip_addir=$1
echo "Scanning $1"

masscan -p1-65535 -i tun0 $1 --rate 1000 -oG /opt/massmap/.logs/masscan.grep
ports=$(cat /opt/massmap/.logs/masscan.grep | grep Ports: | cut -d " " -f 5 | cut -d "/" -f 1 | sed 's/ //g' | tr '\n' ',')

nmap -sV -sC -p $ports $1 -oA $2

echo $ports
