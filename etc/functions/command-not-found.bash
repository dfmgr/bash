#!/usr/bin/env bash
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
##@Version       : 202103251632-git
# @Author        : Jason Hempstead
# @Contact       : jason@casjaysdev.pro
# @License       : LICENSE.md
# @ReadME        : command-not-found.bash --help
# @Copyright     : Copyright: (c) 2021 Jason Hempstead, CasjaysDev
# @Created       : Thursday, Mar 25, 2021 16:42 EDT
# @File          : command-not-found.bash
# @Description   :
# @TODO          :
# @Other         :
# @Resource      :
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
orig_command_not_found_handle() {
  local cmd=$1
  local possibilities=""
  printf_red "$cmd: command not found"
  if type -P pkmgr &>/dev/null; then
    printf_green "Searching the repo for $cmd"
    possibilities="$(pkmgr search show-raw "$cmd" 2>/dev/null | grep -a "$cmd" | sort -u | head -n20 | grep '^' || echo '')"
    exact="$(echo "$possibilities" | awk -F ' ' '{print $1}' | sed 's| ||g' | grep -x "$cmd")"
    [ -n "$exact" ] && pkmgr silent install "$exact" 2>/dev/null
    if type -P "$exact" &>/dev/null || [[ $? = 0 ]]; then
      printf_green "$exact has been Installed"
      sleep 2
      eval "$*"
      return $?
    else
      printf_red "Sorry install of package $cmd failed"
      if [ -n "$possibilities" ]; then
        printf_yellow "However, I did find packages matching $cmd"
        echo "$possibilities" | printf_readline "5"
        if [ -n "$exact" ]; then
          printf_cyan "Found exact match: $exact"
        fi
        echo
      fi
      return 1
    fi
  else
    printf_red "Failed to install $cmd with your package manager"
    return 1
  fi
}
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
command_not_found_handle() {
  cmd="$1"
  args=("$@")
  if [ -f "$cmd" ]; then
    if echo " ${_suffix_vi[*]} " | grep -q " ${cmd##*.} "; then
      if type vi >&/dev/null; then
        vi "${args[@]}" && return 0 || return 1
      fi
    elif [ "${cmd##*.}" = "ps1" ]; then
      if type powershell >&/dev/null; then
        powershell -F "${args[@]}" && return 0 || return 1
      fi
    fi
  fi
  alias cnf="command_not_found_handle"
  orig_command_not_found_handle "${args[@]}"
  return $?
}
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
alias cnf="command_not_found_handle"
alias command-not-found="command_not_found_handle"
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# end
