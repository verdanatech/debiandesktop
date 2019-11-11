#!/bin/bash
# vim: noai:ts=4:sw=4:expandtab
#
# debiandesktop.sh
# http://www.verdanatech.com.br/
# Versao 1.1
#
# The License GLP v3
#
# Copyright (c) 2019 Verdanatech
#
#	A instalacao inicial é a minima.
#	É necessaria a instalacao inicial do wget para download do script e
#	do arquivo com a listagem de pacotes.
#	Para fazer o download do script é necessario a instalacao inicial do 
#	wget com os comandos abaixo:
#	# apt install wget --no-install-recommends --yes
#
#  Em seguida fazer o download dos dois arquivos:
# wget https://raw.githubusercontent.com/luckdomingues/debiandesktop/master/debiandesktop.sh --no-check-certificate
# wget https://raw.githubusercontent.com/luckdomingues/debiandesktop/master/pacotes-para-instalar.txt --no-check-certificate
# 
# Transformar o arquivo executavel
# chmod +x debiandesktop.sh
#
# Executar o script:
# ./debiandesktop.sh
# 

## VARIAVEIS
_diretorioDownloads="/tmp/"

# TODO: adicionar cores
# TODO: adicionar softwares que nao estao no repositorio
# => google chrome
# => projectlibre
# => 

## INICIO FUNCOES
_abertura() {
	clear
	echo " "
	echo "                         GNU LINUX DEBIAN 10               "
	echo " "
	echo " "
	echo "*****************"
	echo "Ola $USER!!!"
	echo "*****************"
	echo " "
	echo " "
	echo " "
	echo "Este script foi criado pela Verdanatech."
	echo "Ele se propoe a fazer a instalar de forma automatica os pacotes"
	echo "mais utilizados para uso diario do GNU/Debian 10 nos desktops."
	echo ""
	echo ""
	echo "==============================================================================="
	echo "*******************************************************************************"
	echo ""
	sleep 8
	echo "Iniciando script"
	sleep 2
	echo "..."
	sleep 2
	echo ".."
	sleep 2
	echo "."
	sleep 2
	echo ""
	echo ""
}

_preInstalacao(){
	apt update
	apt dist-upgrade --yes
    apt autoclean
	apt autoremove --yes
}

_iniciandoServicos(){
	systemctl enable ssh.service
}

_googleChromeInstall(){
	wget -c https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb -P /tmp/
	dpkg -i --force-all /tmp/google-chrome*
}

_projectLibreInstall() {
  wget https://ufpr.dl.sourceforge.net/project/projectlibre/ProjectLibre/1.9.1/projectlibre_1.9.1-1.deb
  dpkg -i projectlibre_1.9.1-1.deb 
  apt -f install
}

_instalacaoPacotesApt(){
# TODO: adicionar um contador com [numero pacote atual:total de pacotes]
if [ -f pacotes-para-instalar.txt ]
then
	for _nomeDoPacote in $(cat pacotes-para-instalar.txt); do
  		if ! dpkg -l | grep -q $_nomeDoPacote; then # Só instala se já não estiver instalado
  			echo "Instalando pacote $_nomeDoPacote"
  		    echo "[START LOG] pacote $_nomeDoPacote" >>install.log
	    	apt install "$_nomeDoPacote" --yes --no-install-recommends | tee -ai install.log
	    	echo "[FINISH LOG] pacote $_nomeDoPacote" >>install.log
	        # verifica se o comando rodou ok
	    	if [ $? -eq 0 ]
	    	then
	    		echo "[OK!] $_nomeDoPacote" >> install.log
	    	else
	    		echo "[ERR] $_nomeDoPacote" >> install.log
	    	fi
	  	else
	   		echo "[JA ESTAVA INSTALADO] - $_nomeDoPacote"
	 	fi
	done
else
	echo "Nao existe o arquivo pacotes-para-instalar.txt"
	exit 1
fi
}

_reiniciar(){
	echo ""
	echo ""
	echo "       Instalacao dos pacotes finalizada!"
	echo "*******************************************************************************"
	echo "==============================================================================="
	sleep 3
	echo ""
	echo ""
	read -r -p "Voce deseja reiniciar ? [s/N]? " prompt
	if [ "$prompt" = s -o "$prompt" = S -o "$prompt" = sim -o "$prompt" = Sim -o "$prompt" = SIM ]
	then
   	 reboot
	else
   	 exit 0
	fi
}

## FIM FUNCOES

## INICIANDO SCRIPT

_abertura
_preInstalacao
_instalacaoPacotesApt
_iniciandoServicos
_reiniciar

#TODO; FIM SCRIPT
#
# Se estiver usando a distribuicao no virtualbox, rodar os comandos:
# apt install linux-headers-$(uname -r) --yes --no-install-recommends
# apt libncurses5-dev gcc make git exuberant-ctags bc libssl-dev dkms kernel-package build-essential --yes --no-install-recommends
# Para instalar posteriormente o Guest Additions (adicionais de convidados)
#
