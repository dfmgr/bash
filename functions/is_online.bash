#!/usr/bin/env bash

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# @Author      : Jason
# @Contact     : casjaysdev@casjay.net
# @File        : is_online.bash
# @Created     : Mon, Jan 6 2021, 00:00 EST
# @License     : WTFPL
# @Copyright   : Copyright (c) CasjaysDev
# @Description : check for internet connection
#
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -


if [ ! -f "$(command -v is_online)" ]; then
is_online() {
  return_code() {
    if [ "$1" = 0 ]; then
      return 0
    else
      return 1
    fi
  }
  test_ping() {
    timeout 0.3 ping -c1 8.8.8.8 &>/dev/null
    local pingExit=$?
    return_code $pingExit
  }
  test_http() {
    curl -LSIs --max-time 1 http://1.1.1.1 | grep "HTTP/2 200" | head -n 1 &>/dev/null
    local httpExit=$?
    return_code $httpExit
  }
  test_ping || test_http
}
fi

# - -- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
