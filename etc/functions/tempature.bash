#!/usr/bin/env bash

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# @Author      : Jason
# @Contact     : casjaysdev@casjay.net
# @File        : Tempature.bash
# @Created     : Mon, Dec 31, 2019, 00:00 EST
# @License     : WTFPL
# @Copyright   : Copyright (c) CasjaysDev
# @Description : tempature conversion
#
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

if ! cmd_exists celcius2f f2celcius; then
  celcius2f() {
    if [ -z "$1" ] || [ $# -ne 1 ]; then
      printf "\t\tUsage: celsius2f 40\n"
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
