#!/usr/bin/env bash
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
##@Version       : 202103251632-git
# @Author        : Jason Hempstead
# @Contact       : jason@casjaysdev.pro
# @License       : LICENSE.md
# @ReadME        : url.bash --help
# @Copyright     : Copyright: (c) 2021 Jason Hempstead, CasjaysDev
# @Created       : Thursday, Mar 25, 2021 17:57 EDT
# @File          : url.bash
# @Description   :
# @TODO          :
# @Other         :
# @Resource      :
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
urlencode() {
  local url="$1" c i out=""
  [[ -z "$url" ]] && url=$(cat -)
  for ((i = 0; i < ${#url}; i++)); do
    c="${url:i:1}"
    case "$c" in
    [a-zA-Z0-9.~_-]) out+="$c" ;;
    *) out+=$(printf '%%%02X' "'$c") ;;
    esac
  done
  printf '%s\n' "$out"
}
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
urldecode() {
  local url="$1" encoded
  [[ -z "$url" ]] && url=$(cat -)
  encoded="${url//+/ }"
  printf '%b\n' "${encoded//%/\\x}"
}
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# expandurl needs a network fetch, so curl is a necessary external command
expandurl() {
  local url="$1"
  if [[ -z "$url" ]]; then
    echo "Usage: expandurl <url>"
    return 1
  fi
  if ! type -P curl >&/dev/null; then
    echo "expandurl: curl is required" >&2
    return 1
  fi
  curl -sSL -o /dev/null -w '%{url_effective}\n' "$url"
}
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# end
