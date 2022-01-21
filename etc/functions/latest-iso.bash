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
  url="$1"
  latest=$(curl -q -LSsf "$url" | grep 'http*.*.*iso' | sed 's|\\/|/|g' | head -n1)
  iso=$(basename "$latest")
  download_file="${2:-$HOME/Downloads}/$iso"
  download_dir=$(dirname "$download_file")
  [ -d "$download_dir" ] || mkdir -p "$download_dir"
  printf_green "Downloading $iso from $url"
  curl -q -LSsf "$latest" -o "$download_file" &&
    printf_green "File saved to $download_file" || {
    printf_red "Error downloading $latest"
    return 1
  }
}
