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
  celsius2f() {
    if [ -z "$1" ] || [ $# -ne 1 ]; then
      printf_help "Usage: celsius2f 40"
      return 1
    fi
    math="$1"
    tf=$(echo "scale=2;((9/5) * $math) + 32" | bc)
    echo $tf
  }

  # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

  f2celcius() {
    if [ -z "$1" ] || [ $# -ne 1 ]; then
      printf_help "Usage: f2celcius 75"
      return 1
    fi
    math="$1"
    tc=$(echo "scale=2;(5/9)*($math-32)" | bc)
    echo $tc
  }
fi
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
