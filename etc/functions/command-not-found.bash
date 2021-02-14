#!/usr/bin/env bash

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# @Author      : Jason
# @Contact     : casjaysdev@casjay.net
# @File        : command-not-found.bash
# @Created     : Mon, Dec 31, 2019, 00:00 EST
# @License     : WTFPL
# @Copyright   : Copyright (c) CasjaysDev
# @Description : command not found function
#
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
orig_command_not_found_handle() {
  cmd="$1"
  args=("$@")
  printf_red "bash: $1: command not found"
  if [ "$OS" = "Linux" ] || cmd_exists findInstallApp; then
    printf_green "Searching the repo for $1"
    sleep 1
    findInstallApp "$1" &&
      printf_green "Package $1 Installed" && return 0 ||
      printf_red "Can not locate package $1" && return 1
  fi
}
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
command_not_found_handle() {
  cmd="$1"
  args=("$@")
  if [[ -f "$cmd" ]]; then
    if echo " ${_suffix_vi[*]} " | grep -q " ${cmd##*.} "; then
      if type vi >&/dev/null; then
        vi "${args[@]}"
        return $?
      fi
    elif [[ "${cmd##*.}" = "ps1" ]]; then
      if type powershell >&/dev/null; then
        powershell -F "${args[@]}"
        return $?
      fi
    fi
  fi
  alias cnf="command_not_found_handle"
  orig_command_not_found_handle "${args[@]}"
}
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
alias cnf="command_not_found_handle"
alias command-not-found="command_not_found_handle"
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# end
