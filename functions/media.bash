#!/usr/bin/env bash

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# @Author      : Jason
# @Contact     : casjaysdev@casjay.net
# @File        : medai.bash
# @Created     : Mon, Dec 31, 2019, 00:00 EST
# @License     : WTFPL
# @Copyright   : Copyright (c) CasjaysDev
# @Description : media functions
#
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# youtube-dl to mplayer

ytstream() {
  youtube-dl --quiet --no-warnings -f best "$1" -o - 2>/dev/null |
    mplayer -cache 1024 -cache-min 10 -really-quiet - 2>/dev/null
}

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# poor man's mpd client

mpcp() {
  echo "$@" | nc -q0 "$MPDSERVER" 6600
}

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# mpd status display in the upper right terminal corner

mpdd() {
  local _r _l _p
  while sleep 1; do
    _r=$(awk 'BEGIN{FS=": "}
                /^Artist:/{r=r""$2};
                /^Title:/{r=r" - "$2};
                /^time:/{r=$2" "r};
                /^state: play/{f=1}
              END{if(f==1){print r}}' <(
      mpc status
      mpc current
    ))

    _l=${#_r}
    [[ $_l -eq 0 ]] && continue
    [[ -z "$_p" ]] && _p=$_l
    echo -ne "\e[s\e[0;${_p}H\e[K\e[u"
    _p=$((COLUMNS - _l))
    echo -ne "\e[s\e[0;${_p}H\e[K\e[0;44m\e[1;33m${_r}\e[0m\e[u"
  done
}

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# returns album art for the "artist - album" input string
# todo: do we need only [,] to be removed or some other chars too?

getart() {
  [[ -z "$ARTDIR" ]] && local ARTDIR="$HOME/.cache/albumart"
  [[ -d "$ARTDIR" ]] || mkdir -p "$ARTDIR"

  local mpccurrent artfile
  mpccurrent="$(echo "$@" | sed -r 's/(\[|\]|\,)//g')"
  artfile=$(find "$ARTDIR" -iname "${mpccurrent}*")
  [[ -z "$artfile" ]] && {
    # customize useragent at http://whatsmyuseragent.com/
    local useragent='Mozilla/5.0 (X11; Ubuntu; Linux i686; rv:31.0) Gecko/20100101 Firefox/31.0'
    local link imagelink ext imagepath
    link="www.google.com/search?q=$(urlencode "$mpccurrent")\&tbm=isch"
    #    imagelinks=$(wget -e robots=off --user-agent "$useragent" -qO - "$link" | sed 's/</\n</g' | grep '<a href.*\(png\|jpg\|jpeg\)' | sed 's/.*imgurl=\([^&]*\)\&.*/\1/')
    imagelinks=$(timeout 10s wget -e robots=off --user-agent "$useragent" -o /dev/null -qO - "$link" | sed 's/</\n</g' | grep "ou\":\"http" | sed -nr 's/.*ou\":\"([^"]+).*/\1/p')
    for imagelink in $imagelinks; do
      imagelink=$(echo "$imagelink" | sed -nr 's/(.*\.(jpg|jpeg|png)).*/\1/p')
      ext=$(echo "$imagelink" | sed -nr 's/.*(\.(jpg|jpeg|png)).*/\1/p')
      imagepath="${ARTDIR}/${mpccurrent}${ext}"
      timeout 10s wget --max-redirect 0 -o /dev/null -qO "$imagepath" "${imagelink}"
      [[ -s "$imagepath" ]] && break
      rm "$imagepath" # remove zero length file
    done
    artfile=$(find "$ARTDIR" -iname "${mpccurrent}*")
  }
  echo "$artfile"
}

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# sends notifications for the new title

notifyart() {
  local artist="$1"
  local title="$2"
  local album="$3"
  [[ -z "$album" ]] && album="$title"
  notify-send "$title" "$artist" -i "$(getart "$artist - $album")" -t 5000
}

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

notifympd() {
  local artist album title oldartist oldtitle
  while true; do
    artist=$(mpc current | awk -F": " '/^Artist:/{print $2}')
    title=$(mpc current | awk -F": " '/^Title:/{print $2}')
    album=$(mpc current | awk -F": " '/^Album:/{print $2}')
    [[ "$artist" != "$oldartist" ]] || [[ "$title" != "$oldtitle" ]] && {
      notifyart "$artist" "$title" "$album"
      oldartist="$artist"
      oldtitle="$title"
    }
    sleep 2
  done
}

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
