#!/bin/bash

#Colores
greenColour="\e[0;32m\033[1m"
endColour="\033[0m\e[0m"
redColour="\e[0;31m\033[1m"
blueColour="\e[0;34m\033[1m"
yellowColour="\e[0;33m\033[1m"
purpleColour="\e[0;35m\033[1m"
turquoiseColour="\e[0;36m\033[1m"
grayColour="\e[0;37m\033[1m"

trap ctrl_c INT

function ctrl_c(){
	echo -e "\n${yellowColour}[*]${endColour}${grayColour} Saliendo... ${endColour}${yellowColour}[*]${endColour}"
	rm /tmp/tmp.* 2>/dev/null
	exit 0
}

function MenuAyuda(){
    echo -e "\n${greenColour}Ayuda de osidentifier.sh${endColour}"
    echo -e "\n\t${yellowColour}-i${endColour}${turquoiseColour} Introducir dirección IP${endColour}"
    echo -e "\t\t${greenColour}Ejemplo:${endColour}${blueColour}./osidentifier.sh -i 172.22.222.1${endColour}"
    echo -e "\n\t${yellowColour}-f${endColour}${turquoiseColour} Introducir fichero con direcciones IP${endColour}"
    echo -e "\t\t${greenColour}Ejemplo:${endColour}${blueColour}./osidentifier.sh -f ips.txt${endColour}"
    exit 0
}

function Readip(){
    clear
    ttl=$(ping -c 1 -W 0.5 $ip | grep ttl | sed 's/.*ttl=\([[:digit:]]*\).*/\1/')
    if [[ "$ttl" ]]; then
    echo -e "\n${yellowColour}TTL-> ${endColour}${turquoiseColour}${ttl}"
    if [[ 0 -lt $ttl ]] && [[ $ttl -le 64 ]]; then
        echo -e "${greenColour}Linux"
    elif [[ 64 -lt $ttl ]] && [[ $ttl -le 128 ]]; then
        echo -e "${greenColour}Windows"
    elif [[ 128 -lt $ttl ]] && [[ $ttl -le 255 ]]; then
        echo -e "${greenColour}Solaris"
    fi
    else
    echo -e "\n${purpleColour}IP $cont:${endColour} ${turquoiseColour}$ip"
    echo -e "\n\t${redColour}[!] El ping ha fallado, puede ser que el Firewall esté bloqueando las trazas ping [!]${endColour}"
    fi
}

function ReadFile(){
    clear
    RegularExpression='(([0-9]|[0-9]{2}|1[0-9]{2}|2[0-4][0-9]|25[0-5])\.){3}([0-9]|[0-9]{2}|1[0-9]{2}|2[0-4][0-9]|25[0-5])'
    tfile=$(mktemp)
    ip=$(egrep -o "$RegularExpression" $file >> $tfile)
    declare -i cont=1
    while read line; do
        ttl=$(ping -c 1 -W 0.5 $line | grep ttl | sed 's/.*ttl=\([[:digit:]]*\).*/\1/')
            echo -e "\n${purpleColour}IP $cont:${endColour} ${turquoiseColour}$line"
            let cont+=1
            if [[ "$ttl" ]]; then
            echo -e "\n\t${yellowColour}TTL-> ${endColour}${turquoiseColour}${ttl}"
            if [ 0 -lt $ttl ] && [ $ttl -le 64 ]; then
                echo -e "\t${greenColour}Linux"
            elif [ 64 -lt $ttl ] && [ $ttl -le 128 ]; then
                echo -e "\t${greenColour}Windows"
            elif [ 128 -lt $ttl ] && [ $ttl -le 255 ]; then
                echo -e "\t${greenColour}Solaris"
            fi
            else
            echo -e "\n\t${redColour}[!] El ping ha fallado, puede ser que el Firewall esté bloqueando las trazas ping [!]${endColour}"
            fi
    done < $tfile
    rm $tfile
}

declare -i cont_par=0; while getopts ":h:i:f:" arg; do
    case $arg in
        h) MenuAyuda;;
        i) ip=$OPTARG; let cont_par+=1;;
        f) file=$OPTARG; let cont_par+=2;;
    esac
done

if [ $cont_par -eq 0 ]; then
    MenuAyuda
elif [ $cont_par -eq 1 ]; then
    Readip
elif [ $cont_par -eq 2 ]; then
    ReadFile
elif [ $cont_par -eq 3 ]; then
    Readip
    ReadFile
fi