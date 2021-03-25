#!/usr/bin/env bash

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# @Author      : Jason
# @Contact     : casjaysdev@casjay.net
# @File        : showbattery.bash
# @Created     : Mon, Dec 31, 2019, 00:00 EST
# @License     : WTFPL
# @Copyright   : Copyright (c) CasjaysDev
# @Description : shows battery status
#
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
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
  upower -i $(upower -e | grep BAT)
}
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# end
