#!/usr/bin/env bash
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
##@Version       : 202201211753-git
# @Author        : Jason Hempstead
# @Contact       : jason@casjaysdev.com
# @License       : WTFPL
# @ReadME        : latest-iso --help
# @Copyright     : Copyright: (c) 2022 Jason Hempstead, Casjays Developments
# @Created       : Friday, Jan 21, 2022 17:53 EST
# @File          : latest-iso
# @Description   :
# @TODO          :
# @Other         :
# @Resource      :
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
latest-iso() {
  local iso url latest download_dir
  [[ "$1" = "tails" ]] && shift 1 && url="https://tails.boum.org/install/dvd-download/index.en.html"
  url="${1:-$url}"
  file="${2:-$file}"
  latest=$(curl -q -LSsf "$url" 2>/dev/null | sed -r 's/.*href="([^"]+).*/\1/g' | grep 'http*.*.*iso' | grep -v 'torrent' | grep 'http' | sed 's|\\/|/|g' | head -n1 | grep '^')
  echo "$latest"
  return 1
  [ -n "$latest" ] || printf_return "No iso found on $url"
  iso=$(basename "$latest" 2>/dev/null)
  download_dir=$(dirname "${2:-$HOME/Downloads}/$iso" 2>/dev/null)
  download_file="$download_dir/$iso"
  [ -e "$download_file" ] && printf_purple "File already exists: $download_file" && return 0
  [ -d "$download_dir" ] || mkdir -p "$download_dir"
  printf_green "Downloading $iso to $download_file"
  curl -q -LSsf "$latest" -o "$download_file" 2>/dev/null &&
    printf_green "File saved to $download_file" || {
    printf_red "Error downloading $url"
    return 1
  }
}
