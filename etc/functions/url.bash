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
#urlencode() {
#  # needs liburi-perl to be installed
#  local url="$1"
#  [[ -z "$url" ]] && url=$(cat -)
#  perl -MURI::Escape -e 'print uri_escape($ARGV[0]);' "$url"
#  echo ""
#}
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

#urldecode() {
#  # needs liburi-perl to be installed
#  local url="$1"
#  [[ -z "$url" ]] && url=$(cat -)
#  perl -MURI::Escape -e 'print uri_unescape($ARGV[0]);' "$url"
#  echo ""
#}
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
#expandurl() {
#  local url=$1
#  [[ -z "$url" ]] && url=$(printclip)
#  [[ -z "$url" ]] && echo "Nothing to expand" && return 1
#  wget -S "$url" 2>&1 | grep ^Location | awk '{print $2}' | tee >(putclip)
#}
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# end
