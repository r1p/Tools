#/bin/bash
 
ayuda(){
        echo "Modo de uno: "
        echo "$0 [Windows/Linux/Solaris] [1-65535]"
}
 
 
lanzarNmap(){
        SO=$(echo "$1" | tr '[:upper:]' '[:lower:]')
        if [ $SO == "windows" ] || [ $SO == "linux" ] || [ $SO == "solaris" ]
        then
                echo "SO correcto: " $SO
                if [ $2 -ge 1 ] && [ $2 -le 65535 ]
                then
                        echo "Puerto correcto: " $2
                        mkdir -p nmap/$SO
                        for x in $(cat IPS_SO.txt | grep -i $SO | grep -oE "([0-9]{1,3}[\.]){3}[0-9]{1,3}")
                        do
                                nmap -sC -sV -p$2 -oA nmap/$SO/$x $x
                        done
                else
                        ayuda
                fi
        else
                ayuda
        fi
}
 
lanzarNmap $1 $2
