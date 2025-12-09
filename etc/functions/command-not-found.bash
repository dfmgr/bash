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
# Cache binary locations
if [ -z "$_CNF_BINS_CACHED" ]; then
  _CNF_BINS_CACHED=1
  _BIN_PKMGR="$(type -P pkmgr 2>/dev/null || true)"
  _BIN_VI="$(type -P vi 2>/dev/null || true)"
  _BIN_POWERSHELL="$(type -P powershell 2>/dev/null || true)"
fi
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
orig_command_not_found_handle() {
  local cmd=$1
  local possibilities=""
  
  # Cache negative lookups to avoid repeated slow searches
  local cache_var="_CNF_CACHE_${cmd//[^a-zA-Z0-9]/_}"
  if [ "${!cache_var}" = "not_found" ]; then
    printf_red "$cmd: command not found"
    return 127
  fi
  
  printf_red "$cmd: command not found"
  if [ -n "$_BIN_PKMGR" ]; then
    printf_green "Searching the repo for $cmd"
    # Reduced timeout from 10s to 3s
    possibilities="$(timeout 3 pkmgr search show-raw "$cmd" 2>/dev/null | grep -a "$cmd" | sort -u | head -n20 | grep '^' || echo '')"
    exact="$(echo "$possibilities" | awk -F ' ' '{print $1}' | sed 's| ||g' | grep -x "$cmd")"
    
    if [ -z "$exact" ]; then
      # Cache negative result
      eval "$cache_var=not_found"
      export "$cache_var"
    fi
    
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
      return 127
    fi
  else
    printf_red "Failed to install $cmd with your package manager"
    # Cache that we don't have a package manager
    eval "$cache_var=not_found"
    export "$cache_var"
    return 127
  fi
}
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
command_not_found_handle() {
  cmd="$1"
  args=("$@")
  if [ -f "$cmd" ]; then
    if echo " ${_suffix_vi[*]} " | grep -q " ${cmd##*.} "; then
      if [ -n "$_BIN_VI" ]; then
        vi "${args[@]}" && return 0 || return 1
      fi
    elif [ "${cmd##*.}" = "ps1" ]; then
      if [ -n "$_BIN_POWERSHELL" ]; then
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
