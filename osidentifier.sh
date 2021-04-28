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

#Función muestra menú de ayuda para el usuario
function MenuAyuda(){
    echo -e "\n${greenColour}Ayuda de osidentifier.sh${endColour}"
    echo -e "\n\t${yellowColour}-i${endColour}${turquoiseColour} Introducir dirección IP${endColour}"
    echo -e "\t\t${greenColour}Ejemplo:${endColour}${blueColour}./osidentifier.sh -i 172.22.222.1${endColour}"
    echo -e "\n\t${yellowColour}-f${endColour}${turquoiseColour} Introducir fichero con direcciones${endColour}"
    echo -e "\t\t${greenColour}Ejemplo:${endColour}${blueColour}./osidentifier.sh -f ips.txt${endColour}"
    exit 0
}

function Readip(){
    clear
    ttl=$(ping -c 1 $2 | grep ttl | sed 's/.*ttl=\([[:digit:]]*\).*/\1/')
    echo -e "\n${yellowColour}TTL->${endColour}${turquoiseColour}${ttl}"
    if [ '0' -g "$ttl" -a "$ttl" -le '64' ]; then
        echo -e "\n${greenColour}Linux"
    elif [ '64' -g "$ttl" -a "$ttl" -le '128' ]; then
        echo -e "\n${greenColour}Windows"
    elif [ '128' -g "$ttl" -a "$ttl" -le '255' ]; then
        echo -e "\n${greenColour}Solaris"
    fi
}

while [[ "$#" -gt 0 ]]; do
    case $1 in
        -h|--help)
        MenuAyuda
        ;;
        -i|--ip)
        Readip
        ;;
    esac
done