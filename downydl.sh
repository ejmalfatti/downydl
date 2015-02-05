#!/bin/bash
# -- UTF 8 --
#================================================
#	Autor: Emanuel Malfatti
#	GitHub: https://ejmalfatti.github.io
#	Email: sflibre@openmailbox.org
#	Web: https://www.sfolibre.wordpress.com
#================================================



# Funcion menu grafico principal
function menuPrincipal()
{
	TXT="			          GUI PARA YOUTUBE-DL"

	menuPrincipal=$(yad --title="Descargar video - Extraer audio" --text="$TXT" --width="400" --height="200" --form  \
	--field="URL del video" --field="Seleccionar opción:CB" "https://" "Descargar audio"!"Descargar video" \
	--button="gtk-ok:0" --button="gtk-cancel:1")
}

# Funcion menu grafico para la parte de audio
function menuAudio()
{
	TXT="			          GUI PARA YOUTUBE-DL"
	menuAudio=$(yad --title="Extrayendo audio de video" --text="$TXT" --width="400" --height="200" --form  \
	--field="Elegir tasa de bits:CB" "96"!"128"!"192"!"320" --field="Seleccionar formato:CB"  "mp3"!"ogg"!"acc" \
	--field="Guardar en...:DIR" --button="gtk-ok:0" --button="gtk-cancel:1")
}

# Funcion menu grafico para la parte de video
function menuVideo()
{
	echo "Menu yad para la parte de video"
}

function downAudio()
{
	local YB
	YB=$(which youtube-dl); #echo $YB
	#echo "$1	$2	$3	$4"
	if [ "$1" == "mp3" ]; then
		"$YB" --extract-audio --audio-format "$1" --audio-quality "$2"k -o "$3/%(title)s.%(ext)s" "$4"
	elif [ "$1" == "ogg" ]; then
		"$YB" --extract-audio --audio-format vorbis --audio-quality "$2"k -o "$3/%(title)s.%(ext)s" "$4"
	elif [ "$1" == "acc" ]; then
		"$YB" --extract-audio --audio-format best --audio-quality "$2"k -o "$3/%(title)s.%(ext)s" "$4"
	fi
	
}

function downVideo()
{
	echo "Descargar el video"
}


#==================================================================#
# BLOQUE PRINCIPAL DEL SCRIPT

FALSE="0"

while [ "$FALSE" != "1" ]; do

	menuPrincipal
	
	FALSE=$(echo $?)

	URL=$(echo $menuPrincipal | cut -d'|' -f1); #echo $URL
	SELECT=$(echo $menuPrincipal | cut -d'|' -f2); #echo $SELECT

	case "$SELECT" in
		"Descargar audio")
			menuAudio
		
			KBPS=$(echo $menuAudio | cut -d'|' -f1); #echo $KBPS
			FORMATO=$(echo $menuAudio | cut -d'|' -f2); #echo $FORMATO
			DIR=$(echo $menuAudio | cut -d'|' -f3); #echo $DIR

			downAudio $FORMATO $KBPS $DIR $URL
			;;
		"Descargar video")
				echo "Llamando a una funcion que descargue el video"
				downVideo
			;;
	esac
done
