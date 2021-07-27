#!/bin/bash

### CORES ###

BREDTEXTWHITE="\e[41;37;01m"
BREDTEXTWHITEP="\e[41;37;05m"
SUBRAYAR="\E[4m"
RESALTAR="\E[7m"
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
	/home/$USER/.config/bspwm/scripts/bspwm_resize {west,south,north,east}

#Open Firefox
super + shift + f
	firejail /opt/firefox/firefox
'


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

bspc node -z "$dir" "$x" "$y" || bspc node -z "$falldir" "$x" "$y"
'

################################################################################################
#################################### bspwmrc #############################################
################################################################################################
 # /home/$USER/.config/bspwm/bspwmrc
$bspwmrc='
#! /bin/sh

pgrep -x sxhkd > /dev/null || sxhkd &

bspc monitor -d I II III IV V VI VII VIII IX X

bspc config border_width         2
bspc config window_gap          12

bspc config split_ratio          0.52
bspc config borderless_monocle   true
bspc config gapless_monocle      true

bspc rule -a Gimp desktop='^8' state=floating follow=on
bspc rule -a Chromium desktop='^2'
bspc rule -a mplayer2 state=floating
bspc rule -a Kupfer.py focus=on
bspc rule -a Screenkey manage=off

#FUNDO DE PANTALLA
feh --bg-fill /home/$USER/Imágenes/FondoPantalla/fondo.jpg
'

################################################################################################
################################################################################################
#################################### polybar ###################################################
################################################################################################
# /home/r0inuj/.config/polybar/workspace.ini

$polybar_workspace='
;; _-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_
;;
;;	    ____        __      __              
;;	   / __ \____  / /_  __/ /_  ____ ______
;;	  / /_/ / __ \/ / / / / __ \/ __ `/ ___/
;;	 / ____/ /_/ / / /_/ / /_/ / /_/ / /    
;;	/_/    \____/_/\__, /_.___/\__,_/_/     
;;	              /____/                    
;;
;; _-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_

;; Global WM Settings

[global/wm]
; Adjust the _NET_WM_STRUT_PARTIAL top value
; Used for top aligned bars
margin-bottom = 0

; Adjust the _NET_WM_STRUT_PARTIAL bottom value
; Used for bottom aligned bars
margin-top = 0

;; _-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_

;; File Inclusion
; include an external file, like module file, etc.

include-file = ~/.config/polybar/colors.ini

;; _-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_

;; Bar Settings

[bar/main]
; Use either of the following command to list available outputs:
; If unspecified, the application will pick the first one it finds.
; $ polybar -m | cut -d ':' -f 1
; $ xrandr -q | grep " connected" | cut -d ' ' -f1
monitor =

; Use the specified monitor as a fallback if the main one is not found.
monitor-fallback =

; Require the monitor to be in connected state
; XRandR sometimes reports my monitor as being disconnected (when in use)
monitor-strict = false

; Tell the Window Manager not to configure the window.
; Use this to detach the bar if your WM is locking its size/position.
;override-redirect = true

; Put the bar at the bottom of the screen
;bottom = true

; Prefer fixed center position for the `modules-center` block
; When false, the center position will be based on the size of the other blocks.
fixed-center = true

; Dimension defined as pixel value (e.g. 35) or percentage (e.g. 50%),
; the percentage can optionally be extended with a pixel offset like so:
; 50%:-10, this will result in a width or height of 50% minus 10 pixels
width = 18%
height = 40

; Offset defined as pixel value (e.g. 35) or percentage (e.g. 50%)
; the percentage can optionally be extended with a pixel offset like so:
; 50%:-10, this will result in an offset in the x or y direction 
; of 50% minus 10 pixels
offset-x = 20
offset-y = 20

; Background ARGB color (e.g. #f00, #ff992a, #ddff1023)
background = ${color.bg}
;background = #A7D6FD
; Foreground ARGB color (e.g. #f00, #ff992a, #ddff1023)
foreground = ${color.fg}

; Background gradient (vertical steps)
;   background-[0-9]+ = #aarrggbb
;;background-0 = 

; Value used for drawing rounded corners
; Note: This shouldn't be used together with border-size because the border 
; doesn't get rounded
; Individual top/bottom values can be defined using:
;   radius-{top,bottom}
radius-top = 10.0
radius-bottom = 10.0

; Under-/overline pixel size and argb color
; Individual values can be defined using:
;   {overline,underline}-size
;   {overline,underline}-color
line-size = 2
line-color = ${color.ac}

; Values applied to all borders
; Individual side values can be defined using:
;   border-{left,top,right,bottom}-size
;   border-{left,top,right,bottom}-color
; The top and bottom borders are added to the bar height, so the effective
; window height is:
;   height + border-top-size + border-bottom-size
; Meanwhile the effective window width is defined entirely by the width key and
; the border is placed withing this area. So you effectively only have the
; following horizontal space on the bar:
;   width - border-right-size - border-left-size
border-size = 0
border-color = ${color.bg}

; Number of spaces to add at the beginning/end of the bar
; Individual side values can be defined using:
;   padding-{left,right}
padding = 2

; Number of spaces to add before/after each module
; Individual side values can be defined using:
;   module-margin-{left,right}
module-margin-left = 1
module-margin-right = 1

; Fonts are defined using <font-name>;<vertical-offset>
; Font names are specified using a fontconfig pattern.
;   font-0 = NotoSans-Regular:size=8;2
;   font-1 = MaterialIcons:size=10
;   font-2 = Termsynu:size=8;-1
;   font-3 = FontAwesome:size=10
; See the Fonts wiki page for more details

font-0 = "Iosevka Nerd Font:size=18;5"
font-1 = "Iosevka Nerd Font:size=12;2"
font-2 = "Iosevka Nerd Font:bold:size=24;2"

; Modules are added to one of the available blocks
;   modules-left = cpu ram
;   modules-center = xwindow xbacklight
;   modules-right = ipc clock

;; Available modules
;;
;alsa backlight battery
;bspwm cpu date
;filesystem github i3
;subscriber demo memory
;menu-apps mpd wired-network
;wireless-network network pulseaudio
;name_you_want temperature my-text-label
;backlight keyboard title workspaces 
;;
;; User modules
;checknetwork updates window_switch launcher powermenu sysmenu menu
;;
;; Bars
;cpu_bar memory_bar filesystem_bar mpd_bar 
;volume brightness battery_bar 

;; _-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_

[bar/primary]
inherit = bar/main

override-redirect = true
wm-restack = bspwm
offset-x = 41%
offset-y = 15
bottom = false
padding = 1
module-margin-left = 0
module-margin-right = 0

modules-center = workspaces

[bar/secondary]
inherit = bar/main
offset-x = 30
offset-y = 70
background = ${color.trans}
foreground = ${color.white}

padding = 1
module-margin-left = 0
module-margin-right = 0

modules-left = name sep title

;; _-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_

; The separator will be inserted between the output of each module
separator =

; This value is used to add extra spacing between elements
; @deprecated: This parameter will be removed in an upcoming version
spacing = 0

; Opacity value between 0.0 and 1.0 used on fade in/out
dim-value = 1.0

; Value to be used to set the WM_NAME atom
; If the value is empty or undefined, the atom value
; will be created from the following template: polybar-[BAR]_[MONITOR]
; NOTE: The placeholders are not available for custom values
wm-name = openbox

; Locale used to localize various module data (e.g. date)
; Expects a valid libc locale, for example: sv_SE.UTF-8
locale = 

; Position of the system tray window
; If empty or undefined, tray support will be disabled
; NOTE: A center aligned tray will cover center aligned modules
;
; Available positions:
;   left
;   center
;   right
;   none
tray-position = none

; If true, the bar will not shift its
; contents when the tray changes
tray-detached = false

; Tray icon max size
tray-maxsize = 16

; DEPRECATED! Since 3.3.0 the tray always uses pseudo-transparency
; Enable pseudo transparency
; Will automatically be enabled if a fully transparent
; background color is defined using `tray-background`
tray-transparent = false

; Background color for the tray container 
; ARGB color (e.g. #f00, #ff992a, #ddff1023)
; By default the tray container will use the bar
; background color.
tray-background = ${color.bg}

; Tray offset defined as pixel value (e.g. 35) or percentage (e.g. 50%)
tray-offset-x = 0
tray-offset-y = 0

; Pad the sides of each tray icon
tray-padding = 0

; Scale factor for tray clients
tray-scale = 1.0

; Restack the bar window and put it above the
; selected window manager's root
;
; Fixes the issue where the bar is being drawn
; on top of fullscreen window's
;
; Currently supported WM's:
;   bspwm
;   i3 (requires: `override-redirect = true`)
wm-restack = bspwm

; Set a DPI values used when rendering text
; This only affects scalable fonts
; dpi = 

; Enable support for inter-process messaging
; See the Messaging wiki page for more details.
enable-ipc = true

; Fallback click handlers that will be called if
; there's no matching module handler found.
click-left = 
click-middle = 
click-right =
scroll-up =
scroll-down =
double-click-left =
double-click-middle =
double-click-right =

; Requires polybar to be built with xcursor support (xcb-util-cursor)
; Possible values are:
; - default   : The default pointer as before, can also be an empty string (default)
; - pointer   : Typically in the form of a hand
; - ns-resize : Up and down arrows, can be used to indicate scrolling
cursor-click = 
cursor-scroll = 

;; WM Workspace Specific

; bspwm
;;scroll-up = bspwm-desknext
;;scroll-down = bspwm-deskprev
;;scroll-up = bspc desktop -f prev.local
;;scroll-down = bspc desktop -f next.local

;i3
;;scroll-up = i3wm-wsnext
;;scroll-down = i3wm-wsprev
;;scroll-up = i3-msg workspace next_on_output
;;scroll-down = i3-msg workspace prev_on_output

;openbox
;awesome
;etc

;; _-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_

;; Application Settings

[settings]
; The throttle settings lets the eventloop swallow up til X events
; if they happen within Y millisecond after first event was received.
; This is done to prevent flood of update event.
;
; For example if 5 modules emit an update event at the same time, we really
; just care about the last one. But if we wait too long for events to swallow
; the bar would appear sluggish so we continue if timeout
; expires or limit is reached.
throttle-output = 5
throttle-output-for = 10

; Time in milliseconds that the input handler will wait between processing events
throttle-input-for = 30

; Reload upon receiving XCB_RANDR_SCREEN_CHANGE_NOTIFY events
screenchange-reload = false

; Compositing operators
; @see: https://www.cairographics.org/manual/cairo-cairo-t.html#cairo-operator-t
compositing-background = source
compositing-foreground = over
compositing-overline = over
compositing-underline = over
compositing-border = over

; Define fallback values used by all module formats
format-foreground = 
format-background = 
format-underline =
format-overline =
format-spacing =
format-padding =
format-margin =
format-offset =

; Enables pseudo-transparency for the bar
; If set to true the bar can be transparent without a compositor.
pseudo-transparency = false

;; _-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_
;;
;;	    __  ___          __      __         
;;	   /  |/  /___  ____/ /_  __/ /__  _____
;;	  / /|_/ / __ \/ __  / / / / / _ \/ ___/
;;	 / /  / / /_/ / /_/ / /_/ / /  __(__  ) 
;;	/_/  /_/\____/\__,_/\__,_/_/\___/____/  
;;
;; _-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_

[module/workspaces]
type = internal/xworkspaces

pin-workspaces = true
enable-click = true
enable-scroll = true
font-0 = Material Icons:style=Regular
font-1 = FontAwesome5Free:style=Solid:pixelsize=10:antialias=false;3
font-2 = FontAwesome5Brands:style=Solid:pixelsize=10:antialias=false;3
;icon-0 = 1;
icon-0 = 1;-
icon-1 = 2;
icon-2 = 3;
icon-3 = 4;
icon-4 = 5;
;icon-default = 
;icon-default = ─
icon-default = ∙
format = <label-state>
format-padding = 0

;label-active = ""
label-active = "∙ "
#label-active-foreground = ${color.blue}
label-active-foreground = #00E000
label-active-background = ${color.bg}

label-occupied = "%icon% "
#label-occupied-foreground = ${color.white}
label-occupied-foreground = #E00000
label-occupied-background = ${color.bg}

label-urgent = "%icon% "
label-urgent-foreground = ${color.ac}
label-urgent-background = ${color.bg}

label-empty = "%icon% "
label-empty-foreground = ${color.white}
label-empty-background = ${color.bg}

;; _-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_

[module/name]
type = internal/xworkspaces

format = <label-state>
format-foreground = ${color.fg}
format-font = 3
format-padding = 0

label-active = "%name%"

label-occupied = 
label-urgent = 
label-empty = 

;; _-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_

[module/title]
type = internal/xwindow

format = <label>
format-foreground = ${color.fg}
format-font = 2

label = %title%
label-maxlen = 20
label-empty = Desktop

;; _-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_

[module/sep]
type = custom/text
content = " | "
content-font = 2

;;content-background = #000
content-foreground = ${color.fg}
;;content-padding = 4

[module/sep2]
type = custom/text
content = "   "

;;content-background = #000
content-foreground = ${color.fg}
;;content-padding = 4

;; _-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_
;;	    __________  ______
;;	   / ____/ __ \/ ____/
;;	  / __/ / / / / /_    
;;	 / /___/ /_/ / __/    
;;	/_____/\____/_/       
;;
;; _-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_

'
################################################################################################















### LINKS ###
paquetes_importantes="sudo apt install build-essential git vim xcb libxcb-util0-dev libxcb-ewmh-dev libxcb-randr0-dev libxcb-icccm4-dev libxcb-keysyms1-dev libxcb-xinerama0-dev libasound2-dev libxcb-xtest0-dev libxcb-shape0-dev -y"
paquete_polybar="sudo apt install cmake cmake-data pkg-config python3-sphinx libcairo2-dev libxcb1-dev libxcb-util0-dev libxcb-randr0-dev libxcb-composite0-dev python3-xcbgen xcb-proto libxcb-image0-dev libxcb-ewmh-dev libxcb-icccm4-dev libxcb-xkb-dev libxcb-xrm-dev libxcb-cursor-dev libasound2-dev libpulse-dev libjsoncpp-dev libmpdclient-dev libcurl4-openssl-dev libnl-genl-3-dev -y"
paquete_picom="sudo apt install meson libxext-dev libxcb1-dev libxcb-damage0-dev libxcb-xfixes0-dev libxcb-shape0-dev libxcb-render-util0-dev libxcb-render0-dev libxcb-randr0-dev libxcb-composite0-dev libxcb-image0-dev libxcb-present-dev libxcb-xinerama0-dev libpixman-1-dev libdbus-1-dev libconfig-dev libgl1-mesa-dev libpcre2-dev libevdev-dev uthash-dev libev-dev libx11-xcb-dev libxcb-glx0-dev -y"
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
	echo "|   2) Instalacion Polybar y feh                |"
	echo "|   3) Instalacion Picom y rofi                 |"
	echo "|   4) Instalacion Hack Nerd Fonts y Firefox    |"
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
				clear ; $paquetes_importantes && echo -e "\n\t\t $BREDTEXTWHITE Paquetes actualizado con suceso $FIMCOR \n"
				sleep 1 ; menu
			;;
		1) echo
				sleep 1 ; echo -e "\n\t\t GIT CLONE $BREDTEXTWHITE BSPWM $FIMCOR \n" && cd ~/Descargas/ && git clone https://github.com/baskerville/bspwm.git || echo -e "\n\t\t GIT CLONE BSPWM $BREDTEXTWHITE ERROR $FIMCOR \n"
				sleep 1 ; echo -e "\n\t\t GIT CLONE $BREDTEXTWHITE SXHKD $FIMCOR \n" && cd ~/Descargas/ && git clone https://github.com/baskerville/sxhkd.git || echo -e "\n\t\t GIT CLONE SXHKD $BREDTEXTWHITE ERROR $FIMCOR \n"
				sleep 2 ; cd ~/Descargas/bspwm/ && make && echo -e "\n\t\t $BREDTEXTWHITE MAKE BSPWM $FIMCOR \n" || echo -e "ERROR COMPILACION /bspwm"
				sleep 2 ; cd ~/Descargas/sxhkd/ && make && echo -e "\n\t\t $BREDTEXTWHITE MAKE SXHKD $FIMCOR \n" || echo -e "ERROR COMPILACION /sxhkd"
				sleep 2 ; cd ~/Descargas/bspwm/ && sudo make install && echo -e "\n\t\t $BREDTEXTWHITE BSPWM INSTALADO $FIMCOR \n" || echo -e "\n\t\t ERRO INSTALACION $BREDTEXTWHITE BSPWM $FIMCOR \n"
				sleep 2 ; cd ~/Descargas/sxhkd/ && sudo make install && echo -e "\n\t\t $BREDTEXTWHITE SXHKD INSTALADO $FIMCOR \n" || echo -e "\n\t\t ERRO INSTALACION $BREDTEXTWHITE SXHKD $FIMCOR \n"
				sleep 2 ; sudo apt install bspwm -y && echo -e "\n\t\t INSTALANDO $BREDTEXTWHITE BSPWM $FIMCOR \n"
				sleep 2 ; echo -e "\n\t\t $BREDTEXTWHITE CARGANDO FICHEROS DE EJEMPLO $FIMCOR \n"
				sleep 2 ; mkdir ~/.config/bspwm || echo -e "\n\t\t ERROR AL CREAR CARPETA EN $BREDTEXTWHITE ~/.config/bspwm $FIMCOR \n"
				sleep 2 ; mkdir ~/.config/sxhkd || echo -e "\n\t\t ERROR AL CREAR CARPETA EN $BREDTEXTWHITE ~/.config/sxhkd $FIMCOR \n"
				sleep 2 ; cd ~/Descargas/bspwm/ && cp examples/bspwmrc ~/.config/bspwm/ && chmod +x ~/.config/bspwm/bspwmrc || echo "\n\t\t ERROR AL COPIAR CARPETA EN $BREDTEXTWHITE ~/.config/bspwm $FIMCOR \n"
				sleep 2 ; cd ~/Descargas/bspwm/ && cp examples/sxhkdrc ~/.config/sxhkd/ && chmod +x ~/.config/sxhkd/sxhkdrc || echo "\n\t\t ERROR AL COPIAR CARPETA EN $BREDTEXTWHITE ~/.config/sxhkd $FIMCOR \n"
				sleep 2 ; echo -e "\n\t\t EDITANDO ARCHIVO DE CONFIGURACION $BREDTEXTWHITE SXHKDRC $FIMCOR \n"
				sleep 2 ; echo -e "$texto_sxhkdrc" > ~/.config/sxhkd/sxhkdrc && echo -e "\n\t\t $BREDTEXTWHITE SXHKDRC COPIADO CON SUCESO $FIMCOR \n" || echo -e "ERROR AL ACTUALIZAR SXHKDRC"
				sleep 2 ; echo -e "\n\t\t $BREDTEXTWHITE CREANDO ARCHIVO BSPWM_RESIZE $FIMCOR \n"
				sleep 2 ; mkdir ~/.config/bspwm/scripts/ && echo -e 'CREADO CARPETA SCRIPTS EN ~/.config/bspwm/' || echo -e 'ERROR AL CREAR CARPETA SCRIPTS EN ~/.config/bspwm/'
				sleep 2 ; echo -e "$bspwm_resize" > ~/.config/bspwm/scripts/bspwm_resize; chmod +x ~/.config/bspwm/scripts/bspwm_resize && echo -e "\n\t\t $BREDTEXTWHITE BSPWM_RESIZE COPIADO CON SUCESO $FIMCOR \n" || echo -e "ERROR AL COPIAR BSPWM_RESIZE"
				sleep 2
				menu
			;;
		2) echo
				sleep 1 ; $paquete_polybar
				sleep 2 ; cd ~/Descargas/ && git clone --recursive https://github.com/polybar/polybar
				sleep 2 ; cd ~/Descargas/polybar/ && mkdir build && sleep 1 && cd build/ && sleep 1 && cmake .. && sleep 1 && make -j $(nproc) && sleep 1 && sudo make install && echo -e "\n\t\t $BREDTEXTWHITE POLYBAR INSTALADO $FIMCOR \n" || echo -e "ERROR INSTALACION POLYBAR"
				sleep 2 ; sudo apt install feh -y
				sleep 2 ; cd ~/Descargas/ && git clone https://github.com/VaughnValle/blue-sky.git
				sleep 2 ; cd ~/Descargas/blue-sky/polybar/ && cp * -r ~/.config/polybar
				sleep 2 ; echo '~/.config/polybar/./launch.sh' >> ~/.config/bspwm/bspwmrc 
				sleep 2 ; cd ~/Descargas/blue-sky/polybar/fonts && sleep 1 && sudo cp * /usr/share/fonts/truetype/ && sleep 1 && fc-cache -v
				sleep 2 ; echo -e "\n\t\t Atualizar con las teclas $BREDTEXTWHITEP super + alt + r $FIMCOR \n"
			;;
		3) echo
				sleep 1 ; sudo apt update && sleep 1 && $paquete_picom
				sleep 2 ; cd ~/Descargas/ && git clone https://github.com/ibhagwan/picom.git
				sleep 2 ; cd ~/Descargas/picom/ && git submodule update --init --recursive && sleep 1 && meson --buildtype=release . build && sleep 1 && ninja -C build && sleep 1 && sudo ninja -C build install && echo -e "\n\t\t $BREDTEXTWHITE PICOM INSTALADO $FIMCOR \n" || echo -e "ERROR INSTALACION PICOM"
				sleep 2 ; mkdir ~/.config/picom && cp ~/Descargas/blue-sky/picom.conf ~/.config/picom/

					#TERMINAR CONFIG PICOM 57:17 VIDEO


				sleep 2 ; sudo apt install rofi && echo -e "\n\t\t $BREDTEXTWHITE ROFI INSTALADO CON SUCESO $FIMCOR \n"
			;;
		4) echo
				wget -q https://github.com/ryanoasis/nerd-fonts/releases/download/v2.1.0/Hack.zip -P ~/Descargas/HackNerdsFonts/
				sleep 1 ; cd /usr/local/share/fonts && sudo mv /home/$USER/Descargas/HackNerdsFonts/Hack.zip . && sudo unzip Hack.zip && sleep 1 && sudo rm Hack.zip

				cd / && sudo chown ${USER}:${USER} opt/
				cd /opt/ && sleep 1 && mv /home/$USER/Descargas/firefox-*.bz2 . && sleep 1 && tar -xf firefox-*.bz2 && sleep 1 && rm firefox-*.bz2
				sudo install firejail -y

			;;
		5) echo
				clear
				echo -e "\n\t\t $BREDTEXTWHITEP Finalizando Script... $FIMCOR \n"
				sleep 1
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