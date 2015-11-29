#!/bin/sh
# Version 0.1
# sáb nov 28 19:51:54 VET 2015
# By e1th0r


if [ -f /etc/debian_version ]; then
	

if [ -x /usr/bin/dialog ]; then


dialog --menu "Script Maestro para configurar servidor del Flisol" 15 50 50 1 "/Una única Interfaz" 2 "/Dos Interfaces de red"  2>temp
 
 
# OK is pressed
if [ "$?" = "0" ]
then
	_return=$(cat temp)
		 
# Se seleccionó squid
	if [ "$_return" = "1" ]
	then
	dialog --title "Una Interfaz" --infobox "Preparar equipo y copiar los archivos de configuración necesarios" 10 50
       aptitude update 
       aptitude install -y squid3 debmirror dnsmasq nfs-kernel-server nginx squid3 tftpd

       #DNSMASQ
	cp dnsmasq/dnsmasq.conf /etc/dnsmasq/dnsmasq.conf_bak
	cp dnsmasq/dnsmasq.conf /etc/dnsmasq/

	#NSF
	cp /etc/exports /etc/exports_bak 
	cp nfs/exports /etc/exports 

	#NGINX
	#cp /etc	/nginx

	#SQUID
	cp /etc/squid/squid.conf /etc/squid/squid.conf_bak
	cp squid/squid.conf /etc/squid/squid.conf

	#TFTP
	cp /etc/tftpd/ /etc/tftpd_bak
	cp -R tftp /etc/tftpd/

	for i in `ls debmirror/*sh`; do
		exec $i
	done;


	fi
										 
# Opción 2, varias interfaces
	if [ "$_return" = "2" ]
	then
	dialog --title "Dos interfaces" --infobox "Preparando y copiando los archivos para servidor con 2 interfaces" 10 50 
	#cp squid/squid.conf /etc/squid/squid.conf_bak
	fi

else
	dialog --title "Proceso Cancelado" --msgbox "Todo el proceso fue cancelado" 10 40
fi

# remove the temp file
rm -f temp


####################################################################

else
	echo "No está instalado Dialog"
fi;

else 
	echo "Este script sólo funciona bajo Debian"
fi;
