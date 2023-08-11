#!/usr/bin/env bash
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
##@Version       : 202103251632-git
# @Author        : Jason Hempstead
# @Contact       : jason@casjaysdev.pro
# @License       : LICENSE.md
# @ReadME        : weather.bash --help
# @Copyright     : Copyright: (c) 2021 Jason Hempstead, CasjaysDev
# @Created       : Thursday, Mar 25, 2021 17:58 EDT
# @File          : weather.bash
# @Description   :
# @TODO          :
# @Other         :
# @Resource      :
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
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
