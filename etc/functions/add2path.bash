#!/usr/bin/env bash
# shellcheck shell=bash
# shellcheck disable=SC2317
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
##@Version       : 202103251632-git
# @Author        : Jason Hempstead
# @Contact       : jason@casjaysdev.pro
# @License       : LICENSE.md
# @ReadME        : add2path.bash --help
# @Copyright     : Copyright: (c) 2021 Jason Hempstead, CasjaysDev
# @Created       : Thursday, Mar 25, 2021 16:41 EDT
# @File          : add2path.bash
# @Description   :
# @TODO          :
# @Other         :
# @Resource      :
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
add2path() {
  local dir="" args="" path="" args="" SET_PATH="" NEW_PATH=""
  local OLD_PATH="$PATH" red="\033[0;31m" green="\033[0;32m" reset="\033[0m"
  __test_path() { echo "$PATH" | tr ':' '\n' | grep -qsxE "${1:-$dir}|${1:-$dir}/" &>/dev/null && return 0 || return 1; }
  __help() { printf '%b\n%b\n' "${green}Usage: add2path [options] [directory]${reset}" "${red}Options: add2path [--init] [--add] [--help] [--remove] [--list]${reset}"; }
  if [ "$1" = '--init' ]; then
    shift 1
    NEW_PATH="$(echo "$PATH" | tr ':' '\n' | grep -v "/.local/bin" | sort -u | grep -v '^$')"
    SET_PATH+="$(printf '%s\n' "$NEW_PATH" | tr ':' '\n' | sed 's|\.$||g' | grep "$HOME" | sort -u | grep -v '^$')"
    SET_PATH+="$(printf '%s\n' "$NEW_PATH" | tr ':' '\n' | sed 's|\.$||g' | grep -v "$HOME" | sort -u | grep -v '^$')"
    SET_PATH="$(printf "%s\n" "$SET_PATH" | sed 's|\.||g' | tr '\n' ':' | sed 's|:::|:|g;s|::|:|g;s|:$||g')"
    [ -n "$SET_PATH" ] && PATH="$HOME/.local/bin:$SET_PATH:." || PATH="$OLD_PATH"
    export PATH
    unset SET_PATH NEW_PATH OLD_PATH
    printf 'New path is now:\n%s\n' "$PATH"
    return 0
  elif [ "$1" = '--add' ]; then
    shift 1
  elif [ "$1" = '--list' ]; then
    shift 1
    echo "$PATH" | tr ':' '\n' | grep -v '^$'
    return 0
  elif [ "$1" = '--help' ]; then
    __help
    return 1
  fi
  # Remove dir from path
  if [ "$1" = 'remove' ] || [ "$1" = '--remove' ] || [ "$1" = 'delete' ] || [ "$1" = '--delete' ]; then
    shift 1
    { [ $# -eq 0 ] || [ "$1" = '--help' ]; } && __help && return 1
    for args in "$@"; do
      [ -e "$args" ] && args="$(realpath "$args")" || args=""
      [ "$args" = '.' ] && args=""
      if [ -n "$args" ]; then
        if [ -n "$args" ] && echo "$PATH" | tr ':' '\n' | grep -qsx "$args" &>/dev/null; then
          path="$(echo "$PATH" | tr ':' '\n' | grep -v '^$' | grep -vsx "$args" | tr '\n' ':')"
          export PATH="$path"
          printf "${green}Deleted %s from PATH ${reset}\n" "$args"
        else
          printf "${red}%s was not not found in PATH ${reset}\n" "$args"
        fi
      else
        printf "${red}An error has occured %s${reset}\n" "$args"
      fi
    done
  else
    # Add dir to path
    if [ $# = 0 ]; then
      dir="$(realpath "$PWD/bin")"
      if [ -d "$dir" ]; then
        if __test_path "$dir"; then
          printf "${red}%s is already in your PATH ${reset}\n" "$dir"
          return
        else
          PATH="$dir:$PATH"
          printf "${green}Added %s to your path ${reset}\n" "$dir"
          return
        fi
      else
        printf "${red}Not adding %s to path due to it not existing ${reset}\n" "$dir"
        return
      fi
    else
      for args in "$@"; do
        [ -e "$args" ] && args="$(realpath "$args")" || args=""
        if [ -n "$args" ]; then
          if [ -d "$args" ]; then
            dir="$args"
          elif [ -f "$args" ]; then
            dir="$(dirname "$args" 2>/dev/null || echo '')"
          fi
          if [ -d "$dir" ]; then
            if __test_path "$dir"; then
              printf "${red}%s is already in your PATH ${reset}\n" "$(realpath "$dir" 2>/dev/null)"
            else
              path="$dir:$PATH"
              export PATH="$path"
              printf "${green}Added %s to your path ${reset}\n" "$(realpath "$dir" 2>/dev/null)"
            fi
          else
            printf "${red}Not adding %s to path due to it not existing ${reset}\n" "$args"
          fi
        else
          printf "${red}An error has occured %s${reset}\n" "$args"
        fi
      done
    fi
  fi
  return ${exitCode:-$?}
} && export -f add2path
