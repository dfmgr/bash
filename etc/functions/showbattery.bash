#!/usr/bin/env bash
# shellcheck shell=bash
# - - - - - - - - - - - - - - - - - - - - - - - -
##@Version           :  202609031422-git
# @@Author           :  Jason Hempstead
# @@Contact          :  git-admin@casjaysdev.pro
# @@License          :  WTFPL
# @@ReadME           :  README.md
# @@Copyright        :  Copyright: (c) 2021 Jason Hempstead, Casjays Developments
# @@Created          :  Thursday, Mar 25, 2021 16:49 EDT
# @@File             :  showbattery.bash
# @@Description      :  show battery charge percentage and status
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
showbattery() {
  local dir=/sys/class/power_supply/BAT0/
  if [[ -e "$dir"/charge_now ]]; then
    echo "$(<"$dir"/status) $(($(<"$dir"/charge_now) * 100 / $(<"$dir"/charge_full)))%"
  elif [[ -e "$dir"/energy_now ]]; then
    echo "$(<"$dir"/status) $(($(<"$dir"/energy_now) * 100 / $(<"$dir"/energy_full)))%"
  fi
}
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# shows battery full statistics
showbatteryfull() {
  local bat
  type -P upower &>/dev/null || return
  bat="$(upower -e | grep BAT)"
  [ -n "$bat" ] && upower -i "$bat"
}
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# end
