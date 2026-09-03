#!/usr/bin/env bash
# shellcheck shell=bash
# - - - - - - - - - - - - - - - - - - - - - - - -
##@Version           :  202609031422-git
# @@Author           :  Jason Hempstead
# @@Contact          :  git-admin@casjaysdev.pro
# @@License          :  WTFPL
# @@ReadME           :  README.md
# @@Copyright        :  Copyright: (c) 2021 Jason Hempstead, Casjays Developments
# @@Created          :  Thursday, Mar 25, 2021 17:57 EDT
# @@File             :  url.bash
# @@Description      :  URL encode/decode and expand helper functions
# @@Changelog        :  standardized header to WTFPL @@-field template
# @@TODO             :
# @@Other            :
# @@Resource         :
# @@Terminal App     :  no
# @@sudo/root        :  no
# @@Template         :  shell/bash
# - - - - - - - - - - - - - - - - - - - - - - - -
# shellcheck disable=SC1001,SC1003,SC2001,SC2003,SC2016,SC2031,SC2090,SC2115,SC2120,SC2155,SC2199,SC2229,SC2317,SC2329
# - - - - - - - - - - - - - - - - - - - - - - - -
VERSION="202609031422-git"
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
