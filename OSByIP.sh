#!/bin/bash

declare -i TTL=0

for x in $(cat IPS.txt)
do
        TTL=$(ping -c 1 -w 1 $x | grep "ttl=" | awk -F " " '{print $6}' | sed -e 's/ttl=//g')
        if [ "$TTL" -eq 0 ] # Comprobamos si la IP esta caida
        then
                : # No hacer nada

        elif [ "$TTL" -le 64 ]
        then
                echo $x "= Linux, TTL=" $TTL


        elif [ "$TTL" -ge 65 -a "$TTL" -le 128 ]
        then
                echo $x "= Windows, TTL=" $TTL


        else
                echo $x "= Solaris / Cisco, TTL=" $TTL
        fi
done
