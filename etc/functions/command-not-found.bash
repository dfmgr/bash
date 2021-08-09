#!/usr/bin/env bash
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
##@Version       : 202103251632-git
# @Author        : Jason Hempstead
# @Contact       : jason@casjaysdev.com
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
  cmd="$1"
  args="$@"
  printf_red "$1: command not found"
  sudo -n true || ask_for_password true
  if type pkmgr &>/dev/null; then
    printf_green "Searching the repo for $1"
    pkmgr silent install "$1" 2>/dev/null
    if type -P "$1" &>/dev/null; then
      printf_green "$1 has been Installed"
      return 0
    else
      printf_red "Can not locate package $1"
      local possibilities="$(pkmgr search show-raw "$1" | grep -a "^$1" | head -n10 | grep '^')"
      if [ -n "$possibilities" ]; then
        printf_cyan "However, I did find packages matching $1"
        echo "$possibilities" | printf_readline "5"
        echo
      fi
      return 1
    fi
  else
    printf_red "Maybe you should try installing $1 with your package manager"
    return 1
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
        return $? && return 0 || return 1
      fi
    elif [[ "${cmd##*.}" = "ps1" ]]; then
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
