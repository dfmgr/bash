#!/usr/bin/env bash
# shellcheck shell=bash
# - - - - - - - - - - - - - - - - - - - - - - - -
##@Version           :  202609031422-git
# @@Author           :  Jason Hempstead
# @@Contact          :  git-admin@casjaysdev.pro
# @@License          :  WTFPL
# @@ReadME           :  README.md
# @@Copyright        :  Copyright: (c) 2021 Jason Hempstead, Casjays Developments
# @@Created          :  Thursday, Mar 25, 2021 16:42 EDT
# @@File             :  command-not-found.bash
# @@Description      :  Handles command-not-found lookups, offering to search/install via pkmgr
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
orig_command_not_found_handle() {
  local cmd=$1
  local possibilities="" exact=""
  printf_red "$cmd: command not found"
  if type -P pkmgr &>/dev/null; then
    printf_green "Searching the repo for $cmd"
    # Bound pkmgr calls with `timeout` so a hung search/install (e.g. when
    # the missing token is a zsh builtin like `_arguments` and pkmgr ends up
    # spawning itself) cannot stall the interactive shell indefinitely.
    # Skip the search entirely on tokens that look like internal shell
    # symbols — these are never installable packages.
    case "$cmd" in
      _*|*[\(\){}\$\!\<\>\|]*) return 127 ;;
    esac
    possibilities="$(timeout 5 pkmgr search show-raw "$cmd" 2>/dev/null | grep -a "$cmd" | sort -u | head -n20 | grep '^' || echo '')"
    exact="$(echo "$possibilities" | awk -F ' ' '{print $1}' | sed 's| ||g' | grep -x "$cmd")"
    [ -n "$exact" ] && timeout 30 pkmgr silent install "$exact" 2>/dev/null
    if type -P "$exact" &>/dev/null; then
      printf_green "$exact has been Installed"
      sleep 2
      "$@"
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
  local cmd="$1"
  local args=("$@")
  if [ -f "$cmd" ]; then
    if echo " ${_suffix_vi[*]:-} " | grep -q " ${cmd##*.} "; then
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
