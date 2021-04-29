# osidentifier

osidentifier es una herramienta simple creada en bash que permite identificar el sistema operativo de una máquina a través del TTL.

## Instalación
Clonamos el repositorio en el directorio que deseemos:<br/>
>git clone https://github.com/adiaguilar/osidentifier.git<br/><br/>
>cd osidentifier<br/><br/>
>chmod +x osidentifier.sh<br/>

Para mayor facilidad, podemos poner esta herramienta en el path de configuración de nuestra shell y así poder ejecutarla en cualquier directorio sin necesidad de estar en la ruta del script, se recomienda introducir el script en *$HOME/.local/bin* para mayor comodidad:<br/>
>mv osidentifier.sh ~/.local/bin<br/><br/>
>sudo nano ~/.bashrc<br/><br/>
>Añadir al PATH=/home/$USER/.local/bin<br/><br/>
>source ~/.bashrc<br/>

## Uso de la herramienta

osidentifier cuenta con un parámetro de ayuda, también tiene otros dos parámetros donde se puede introducir una dirección IP o anexar un fichero con múltiples direcciones IP.
```
-h:	Muestra el panel de ayuda
-i:	Sirve para introducir la dirección IP (Uso: ./osidentifier -i 8.8.8.8)
-f: Introducir un fichero con direcciones IP (Uso: ./osidentifier -f ips.txt)
```
