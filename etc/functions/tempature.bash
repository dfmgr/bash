#!/usr/bin/env bash
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
##@Version       : 202103251632-git
# @Author        : Jason Hempstead
# @Contact       : jason@casjaysdev.com
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
if ! cmd_exists celcius2f f2celcius; then
  celcius2f() {
    if [ -z "$1" ] || [ $# -ne 1 ]; then
      printf "\t\tUsage: celcius2f 40\n"
      return 1
    fi
    math="$1"
    tf=$(echo "scale=2;((9/5) * $math) + 32" | bc)
    printf "\t\t$tf\n"
  }
  # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  f2celcius() {
    if [ -z "$1" ] || [ $# -ne 1 ]; then
      printf "\t\tUsage: f2celcius 75\n"
      return 1
    fi
    math="$1"
    tc=$(echo "scale=2;(5/9)*($math-32)" | bc)
    printf "\t\t$tf\n"
  }
fi
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# end
