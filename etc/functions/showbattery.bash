#!/usr/bin/env bash
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
##@Version       : 202103251632-git
# @Author        : Jason Hempstead
# @Contact       : jason@casjaysdev.com
# @License       : LICENSE.md
# @ReadME        : showbattery.bash --help
# @Copyright     : Copyright: (c) 2021 Jason Hempstead, CasjaysDev
# @Created       : Thursday, Mar 25, 2021 16:49 EDT
# @File          : showbattery.bash
# @Description   :
# @TODO          :
# @Other         :
# @Resource      :
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
