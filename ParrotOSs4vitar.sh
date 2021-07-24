#!/bin/bash

### CORES ###

BREDTEXTWHITE="\e[41;37;01m"
BREDTEXTWHITEP="\e[41;37;05m"
FIMCOR="\e[m"

################################################################################################
#################################### sxhkdrc  ##################################################
################################################################################################
texto_sxhkdrc='#
# wm independent hotkeys
#

# terminal emulator
super + Return
	gnome-terminal

# program launcher
super + d
	rofi -show run

# make sxhkd reload its configuration files:
super + Escape
	pkill -USR1 -x sxhkd

#
# bspwm hotkeys
#

# quit/restart bspwm
super + alt + {q,r}
	bspc {quit,wm -r}

# close and kill
super + {_,shift + }w
	bspc node -{c,k}

# alternate between the tiled and monocle layout
super + m
	bspc desktop -l next

# send the newest marked node to the newest preselected node
super + y
	bspc node newest.marked.local -n newest.!automatic.local

# swap the current node and the biggest node
super + g
	bspc node -s biggest

#
# state/flags
#

# set the window state
super + {t,shift + t,s,f}
	bspc node -t {tiled,pseudo_tiled,floating,fullscreen}

# set the node flags
super + ctrl + {m,x,y,z}
	bspc node -g {marked,locked,sticky,private}

#
# focus/swap
#

super + {_,shift + }{Left,Down,Up,Right}
       bspc node -{f,s} {west,south,north,east}


# focus the node for the given path jump
super + {p,b,comma,period}
	bspc node -f @{parent,brother,first,second}

# focus the next/previous node in the current desktop
super + {_,shift + }c
	bspc node -f {next,prev}.local

# focus the next/previous desktop in the current monitor
super + bracket{left,right}
	bspc desktop -f {prev,next}.local

# focus the last node/desktop
super + {grave,Tab}
	bspc {node,desktop} -f last

# focus the older or newer node in the focus history
super + {o,i}
	bspc wm -h off; \
	bspc node {older,newer} -f; \
	bspc wm -h on

# focus or send to the given desktop
super + {_,shift + }{1-9,0}
	bspc {desktop -f,node -d} '^{1-9,10}'

#
# preselect
#

# preselect the direction
super + ctrl + alt + {Left,Down,Up,Right}
	bspc node -p {west,south,north,east}


# preselect the ratio
super + ctrl + {1-9}
	bspc node -o 0.{1-9}

# cancel the preselection for the focused node
super + ctrl + space
	bspc node -p cancel

# cancel the preselection for the focused desktop
super + ctrl + alt + space
	bspc query -N -d | xargs -I id -n 1 bspc node id -p cancel

#
# move/resize
#

# expand a window by moving one of its side outward
#super + alt + {h,j,k,l}
#	bspc node -z {left -20 0,bottom 0 20,top 0 -20,right 20 0}

# contract a window by moving one of its side inward
#super + alt + shift + {h,j,k,l}
#	bspc node -z {right -20 0,top 0 20,bottom 0 -20,left 20 0}

# move a floating window
super + ctrl + {Left,Down,Up,Right}
	bspc node -v {-20 0,0 20,0 -20,20 0}

# Custom move/resize
alt + super + {Left,Down,Up,Right}
	/home/s4vitar/.config/bspwm/scripts/bspwm_resize {west,south,north,east}'
################################################################################################
#################################### bspwm_resize  #############################################
################################################################################################
bspwm_resize='#!/usr/bin/env dash

if bspc query -N -n focused.floating > /dev/null; then
	step=20
else
	step=100
fi

case "$1" in
	west) dir=right; falldir=left; x="-$step"; y=0;;
	east) dir=right; falldir=left; x="$step"; y=0;;
	north) dir=top; falldir=bottom; x=0; y="-$step";;
	south) dir=top; falldir=bottom; x=0; y="$step";;
esac

bspc node -z "$dir" "$x" "$y" || bspc node -z "$falldir" "$x" "$y"'
################################################################################################

### LINKS ###
paquetes="sudo apt install build-essential git vim xcb libxcb-util0-dev libxcb-ewmh-dev libxcb-randr0-dev libxcb-icccm4-dev libxcb-keysyms1-dev libxcb-xinerama0-dev libasound2-dev libxcb-xtest0-dev libxcb-shape0-dev -y"
parrotupgrade="sudo parrot-upgrade -y"

menu(){
	clear
	echo "+-----------------------------------------------+"
	echo -e "\t\t Bienvenido $BREDTEXTWHITE `whoami` $FIMCOR"
	echo "+-----------------------------------------------+"
	echo "|   a) Parrot-Upgrade                           |"
	echo "|   b) Paquetes importantes                     |"
	echo "+-----------------------------------------------+"
	echo "|   1) Instalacion de BSPWM y SXHKD             |"
	echo "|   2)                                          |"
	echo "|   3)                                          |"
	echo "|   4)                                          |"
	echo "|   5) Exit                                     |"
	echo "+-----------------------------------------------'"
	echo "|"
	read -n1 -p "'--- Opcion: " escolha

	case $escolha in
		A|a) echo
				clear ; $parrotupgrade && echo -e "\n\t\t $BREDTEXTWHITE ParrotOS actualizado con suceso $FIMCOR \n"
				sleep 1 ; menu
			;;
		B|b) echo
				clear ; $paquetes && echo -e "\n\t\t $BREDTEXTWHITE Paquetes actualizado con suceso $FIMCOR \n"
				sleep 1 ; menu
			;;
		1) echo
				sleep 1 ; echo -e "\n\t\t GIT CLONE $BREDTEXTWHITE BSPWM $FIMCOR \n" && cd ~/Descargas/ && git clone https://github.com/baskerville/bspwm.git || echo -e "\n\t\t GIT CLONE BSPWM $BREDTEXTWHITE ERROR $FIMCOR \n"
				sleep 1 ; echo -e "\n\t\t GIT CLONE $BREDTEXTWHITE SXHKD $FIMCOR \n" && cd ~/Descargas/ && git clone https://github.com/baskerville/sxhkd.git || echo -e "\n\t\t GIT CLONE SXHKD $BREDTEXTWHITE ERROR $FIMCOR \n"

				sleep 2 ; cd ~/Descargas/bspwm/ && make && echo -e "\n\t\t $BREDTEXTWHITE MAKE BSPWM $FIMCOR \n" || echo -e "ERROR COMPILACION /bspwm"
				sleep 2 ; cd ~/Descargas/sxhkd/ && make && echo -e "\n\t\t $BREDTEXTWHITE MAKE SXHKD $FIMCOR \n" || echo -e "ERROR COMPILACION /sxhkd"

				sleep 2 ; cd ~/Descargas/bspwm/ && sudo make install && echo -e "\n\t\t $BREDTEXTWHITE BSPWM INSTALADO $FIMCOR \n" || echo -e "\n\t\t ERRO INSTALACION $BREDTEXTWHITE BSPWM $FIMCOR \n"
				sleep 2 ; cd ~/Descargas/sxhkd/ && sudo make install && echo -e "\n\t\t $BREDTEXTWHITE SXHKD INSTALADO $FIMCOR \n" || echo -e "\n\t\t ERRO INSTALACION $BREDTEXTWHITE SXHKD $FIMCOR \n"

				sleep 2 ; echo -e "\n\t\t $BREDTEXTWHITE CARGANDO FICHEROS DE EJEMPLO $FIMCOR \n"

				sleep 2 ; mkdir ~/.config/bspwm || echo -e "\n\t\t ERROR AL CREAR CARPETA EN $BREDTEXTWHITE ~/.config/bspwm $FIMCOR \n"
				sleep 2 ; mkdir ~/.config/sxhkd || echo -e "\n\t\t ERROR AL CREAR CARPETA EN $BREDTEXTWHITE ~/.config/sxhkd $FIMCOR \n"

				sleep 2 ; cd ~/Descargas/bspwm/ && cp examples/bspwmrc ~/.config/bspwm/ && chmod +x ~/.config/bspwm/bspwmrc || echo "\n\t\t ERROR AL COPIAR CARPETA EN $BREDTEXTWHITE ~/.config/bspwm $FIMCOR \n"
				sleep 2 ; cd ~/Descargas/bspwm/ && cp examples/sxhkdrc ~/.config/sxhkd/ && chmod +x ~/.config/sxhkd/sxhkdrc || echo "\n\t\t ERROR AL COPIAR CARPETA EN $BREDTEXTWHITE ~/.config/sxhkd $FIMCOR \n"

				sleep 2 ; echo -e "\n\t\t EDITANDO ARCHIVO DE CONFIGURACION $BREDTEXTWHITE SXHKDRC $FIMCOR \n"

				sleep 2 ; echo -e "$texto_sxhkdrc" > ~/.config/sxhkd/sxhkdrc && echo -e "\n\t\t SXHKDRC COPIADO CON SUCESO $FIMCOR \n" || echo -e "ERROR AL ACTUALIZAR SXHKDRC"

				sleep 2 ; echo -e "\n\t\t $BREDTEXTWHITE CREANDO ARCHIVO BSPWM_RESIZE $FIMCOR \n"


				sleep 2 ; mkdir ~/.config/bspwm/scripts/ || echo 'CREANDO CARPETA SCRIPTS EN ~/.config/bspwm/scripts/'
				sleep 2 ; echo -e "$bspwm_resize" > ~/.config/bspwm/scripts/bspwm_resize; chmod +x ~/.config/bspwm/scripts/bspwm_resize && echo -e "\n\t\t BSPWM_RESIZE COPIADO CON SUCESO $FIMCOR \n" || echo -e "ERROR AL COPIAR BSPWM_RESIZE"


			;;
		D|d) echo
			;;
		5) echo
				clear
				echo -e "\n\t\t $BREDTEXTWHITEP Finalizando Script... $FIMCOR \n"
				sleep 2
				exit 0
			;;
		*) echo
				clear
				echo -e "\n\t\t $BREDTEXTWHITEP Opcion equivocada... $FIMCOR \n"
				sleep 2
				menu
			;;
	esac
}
menu