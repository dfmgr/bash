#!/usr/bin/env bash
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
##@Version       : 202111051202-git
# @Author        : Jason Hempstead
# @Contact       : jason@casjaysdev.pro
# @License       : WTFPL
# @ReadME        : dirignore.bash --help
# @Copyright     : Copyright: (c) 2021 Jason Hempstead, Casjays Developments
# @Created       : Friday, Nov 05, 2021 12:02 EDT
# @File          : dirignore.bash
# @Description   : add dirignore message to .gitignore file
# @TODO          :
# @Other         :
# @Resource      :
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
dirignore() {
  local IGNORE_FILE DATE_FMT
  if [ "$1" == "--help" ]; then
    printf_help "add dirignore message to .gitignore file"
    return
  fi
  IGNORE_FILE="${1:-$PWD}/.gitignore"
  DATE_FMT="$(date '+%h-%d-%Y at %H:%M')"
  if [ -f "$IGNORE_FILE" ]; then
    if grep -qs 'ignoredirmessage' "$IGNORE_FILE"; then
      printf_blue 'dirignore is already in .gitignore'
    else
      printf_green 'Adding dirignore to gitignore'
      printf '# Disable reminder in prompt\nignoredirmessage\n' >>"$IGNORE_FILE"
    fi
  else
    printf_green 'Adding dirignore to gitignore'
    printf '# gitignore created on %s\n' "$DATE_FMT" >"$IGNORE_FILE"
    printf '# Disable reminder in prompt\nignoredirmessage\n' >>"$IGNORE_FILE"
  fi
}
