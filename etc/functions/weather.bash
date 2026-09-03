#!/usr/bin/env bash
# shellcheck shell=bash
# - - - - - - - - - - - - - - - - - - - - - - - -
##@Version           :  202609031422-git
# @@Author           :  Jason Hempstead
# @@Contact          :  git-admin@casjaysdev.pro
# @@License          :  WTFPL
# @@ReadME           :  README.md
# @@Copyright        :  Copyright: (c) 2021 Jason Hempstead, Casjays Developments
# @@Created          :  Thursday, Mar 25, 2021 17:58 EDT
# @@File             :  weather.bash
# @@Description      :  wttr.in weather lookup functions
# @@Changelog        :  standardized header to WTFPL @@-field template
# @@TODO             :
# @@Other            :
# @@Resource         :
# @@Terminal App     :  no
# @@sudo/root        :  no
# @@Template         :  shell/bash
# - - - - - - - - - - - - - - - - - - - - - - - -
# shellcheck disable=SC1001,SC1003,SC2001,SC2003,SC2016,SC2031,SC2090,SC2115,SC2120,SC2155,SC2199,SC2229,SC2317,SC2329
# - - - - - - - - - - - - - - - - - - - - - - - -
VERSION="202609031422-git"
wttrin() {
  curl -q -LSs "http://wttr.in/$1?AFu$2" | grep -v "Location" && echo -e "\n\n"
}
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
wttrin2() {
  curl -q -LSs "http://v2.wttr.in/$1?AFu$2" | grep -v "Location" && echo -e "\n\n"
}
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# shows weather in a city
wttrcity() {
  wttrfull "$@" | head -n 7
}
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
wttrfull() {
  wget -q -O - "http://wttr.in/$1?AFu$2"
}
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# end
