#!/usr/bin/env bash
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
##@Version       : 202103251632-git
# @Author        : Jason Hempstead
# @Contact       : jason@casjaysdev.pro
# @License       : LICENSE.md
# @ReadME        : tempature.bash --help
# @Copyright     : Copyright: (c) 2021 Jason Hempstead, CasjaysDev
# @Created       : Thursday, Mar 25, 2021 17:56 EDT
# @File          : tempature.bash
# @Description   : Tempature conversion
# @TODO          :
# @Other         :
# @Resource      :
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
celcius2f() {
  if [ -z "$1" ] || [ $# -ne 1 ]; then
    printf "Usage: celcius2f 40\n"
    return 1
  fi
  math="$1"
  tf=$(echo "scale=2;((9/5) * $math) + 32" | bc)
  printf '%s\n' "$tf"
}
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
f2celcius() {
  if [ -z "$1" ] || [ $# -ne 1 ]; then
    printf "Usage: f2celcius 75\n"
    return 1
  fi
  math="$1"
  tc=$(echo "scale=2;(5/9)*($math-32)" | bc)
  printf '%s\n' "$tf"
}
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# end
