#!/usr/bin/env bash

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# @Author      : Jason
# @Contact     : casjaysdev@casjay.net
# @File        : url.bash
# @Created     : Mon, Dec 31, 2019, 00:00 EST
# @License     : WTFPL
# @Copyright   : Copyright (c) CasjaysDev
# @Description : url functions
#
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
urlencode() {
  # needs liburi-perl to be installed
  local url="$1"
  [[ -z "$url" ]] && url=$(cat -)
  perl -MURI::Escape -e 'print uri_escape($ARGV[0]);' "$url"
  echo ""
}
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

urldecode() {
  # needs liburi-perl to be installed
  local url="$1"
  [[ -z "$url" ]] && url=$(cat -)
  perl -MURI::Escape -e 'print uri_unescape($ARGV[0]);' "$url"
  echo ""
}
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
expandurl() {
  local url=$1
  [[ -z "$url" ]] && url=$(printclip)
  [[ -z "$url" ]] && echo "Nothing to expand" && return 1
  wget -S "$url" 2>&1 | grep ^Location | awk '{print $2}' | tee >(putclip)
}
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# end
