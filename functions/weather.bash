#!/usr/bin/env bash

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# @Author      : Jason
# @Contact     : casjaysdev@casjay.net
# @File        : weather.bash
# @Created     : Mon, Dec 31, 2019, 00:00 EST
# @License     : WTFPL
# @Copyright   : Copyright (c) CasjaysDev
# @Description : weather functions
#
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

wttrin() {
  curl -LSs http://wttr.in/$1?AFu$2 | grep -v "Location" && echo -e "\n\n"
}

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

wttrin2() {
  curl -LSs http://v2.wttr.in/$1?AFu$2 | grep -v "Location" && echo -e "\n\n"
}

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# shows weather in a city
wttrcity() {
  wttrfull "$@" | head -n 7
}

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

wttrfull() {
  wget -q -O - http://wttr.in/$1?AFu$2
}

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
