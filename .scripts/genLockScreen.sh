#!/usr/bin/env bash
# Dependencies: imagemagick, i3lock-color-git, scrot
set -o errexit -o noclobber -o nounset

HUE=(-level 0%,100%,0.6)
EFFECT=(-filter Gaussian -resize 20% -define filter:sigma=1.5 -resize 500.5%)
# default system sans-serif font
FONT="$(convert -list font | awk "{ a[NR] = \$2 } /family: $(fc-match sans -f "%{family}\n")/ { print a[NR-1]; exit }")"
IMAGE="$(mktemp).png"
#IMAGE="/home/iceman/.scripts/screenLock.png"

OPTIONS="Options:
    -h, --help   This help menu.
    -g, --greyscale  Set background to greyscale instead of color.
    -p, --pixelate   Pixelate the background instead of blur, runs faster.
    -f <fontname>, --font <fontname>  Set a custom font. Type 'convert -list font' in a terminal to get a list."

# move pipefail down as for some reason "convert -list font" returns 1
set -o pipefail
trap 'rm -f "$IMAGE"' EXIT
TEMP="$(getopt -o :hpgf: -l help,pixelate,greyscale,font: --name "$0" -- "$@")"
eval set -- "$TEMP"

while true ; do
    case "$1" in
        -h|--help)
            printf "Usage: $(basename $0) [options]\n\n$OPTIONS\n\n" ; exit 1 ;;
        -g|--greyscale) HUE=(-level 0%,100%,0.6 -set colorspace Gray -separate -average) ; shift ;;
        -p|--pixelate) EFFECT=(-scale 10% -scale 1000%) ; shift ;;
        -f|--font)
            case "$2" in
                "") shift 2 ;;
                *) FONT=$2 ; shift 2 ;;
            esac ;;
        --) shift ; break ;;
        *) echo "error" ; exit 1 ;;
    esac
done

# get path where the script is located to find the lock icon
SCRIPTPATH=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
SCRIPTPATH=$SCRIPTPATH"/icons"

# l10n support
TEXT="Your shouldn't be here..."
case "$LANG" in
    de_* ) TEXT="Bitte Passwort eingeben" ;; # Deutsch
    en_* ) TEXT="You shouldn't be here..." ;; # English
    es_* ) TEXT="Ingrese su contraseña" ;; # Española
    fr_* ) TEXT="Entrez votre mot de passe" ;; # Français
    pl_* ) TEXT="Podaj hasło" ;; # Polish
esac

VALUE="60" #brightness value to compare to
scrot -z "$IMAGE"
COLOR=$(convert "$IMAGE" -gravity center -crop 100x100+0+0 +repage -colorspace hsb \
    -resize 1x1 txt:- | awk -F '[%$]' 'NR==2{gsub(",",""); printf "%.0f\n", $(NF-1)}');
if [ "$COLOR" -gt "$VALUE" ]; then #white background image and black text
    BW="black"
    ICON="$SCRIPTPATH/lockdark.png"
    PARAM=(--textcolor=00000000 --insidecolor=0000001c --ringcolor=0000003e \
        --linecolor=00000000 --keyhlcolor=ffffff80 --ringvercolor=ffffff00 \
        --separatorcolor=22222260 --insidevercolor=ffffff1c \
        --ringwrongcolor=ffffff55 --insidewrongcolor=ffffff1c)
else #black
    BW="white"
    ICON="$SCRIPTPATH/lock.png"
    PARAM=(--textcolor=ffffff00 --insidecolor=ffffff1c --ringcolor=ffffff3e \
        --linecolor=ffffff00 --keyhlcolor=00000080 --ringvercolor=00000000 \
        --separatorcolor=22222260 --insidevercolor=0000001c \
        --ringwrongcolor=00000055 --insidewrongcolor=0000001c)
fi

convert "$IMAGE" "${HUE[@]}" "${EFFECT[@]}" -font "$FONT" -pointsize 26 -fill "$BW" -gravity center \
    -annotate +0+160 "$TEXT" "$ICON" -gravity center -composite "$IMAGE"

cp $IMAGE /home/iceman/.scripts/screenLock.png

# try to use a forked version of i3lock with prepared parameters
#if ! i3lock -n "${PARAM[@]}" -i "$IMAGE" > /dev/null 2>&1; then
    # We have failed, lets get back to stock one
#    i3lock -n -i "$IMAGE"
#fi
