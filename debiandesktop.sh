#!/bin/bash




# Lista de aplicativos a serem instalados:
#
#<interface gráfica>
# gnome-shell
#
#
#<editores de imagens>
# gimp, 
# inkscape
# Draw.io
#
#<produtividade>
# Libreoffice, 
# projectLibre 
# xournal
#

gimpInstall() {
  apt install gimp -y
}

inkscapeInstall() {
  apt install inkscape
}

projectLibreInstall() {
  wget https://ufpr.dl.sourceforge.net/project/projectlibre/ProjectLibre/1.9.1/projectlibre_1.9.1-1.deb
  dpkg -i projectlibre_1.9.1-1.deb 
  apt-get -f install
}
