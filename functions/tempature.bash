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
    tf=$(echo "scale=2;((9/5) * $1) + 32" | bc)
    echo $tf
  }

  # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

  f2celcius() {
    tc=$(echo "scale=2;(5/9)*($1-32)" | bc)
    echo $tc
  }
fi
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
