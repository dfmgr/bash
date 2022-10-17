#!/usr/bin/env bash
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
##@Version       : 202103251632-git
# @Author        : Jason Hempstead
# @Contact       : jason@casjaysdev.com
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
  __test_path() { echo "$PATH" | tr ':' '\n' | grep -qsx "${1:-$dir}" &>/dev/null && return 0 || return 1; }
  __help() {
    local red="\033[0;31m"
    local green="\033[0;32m"
    local reset="\033[0m"
    echo -e "${green}Usage: add2path [options] [directory]${reset}"
    echo -e "${red}Options: add2path [--add] [--help] [--remove] [--list]${reset}\n"
  }
  local dir=""
  local args=""
  local path=""
  local red="\033[0;31m"
  local green="\033[0;32m"
  local reset="\033[0m"
  local args=""
  if [[ "$1" = 'init' ]]; then
    shift 1
    NEWPATH="$(echo "$PATH" | tr ':' '\n' | sort -u | grep -v '^$')"
    printf '%s\n' "$NEWPATH" | tr ':' '\n' | sed 's|\.$||g' | grep "$HOME" | sort -u | grep -v '^$' | xargs -I{} echo "export PATH=\"\$PATH:{}\""
    printf '%s\n' "$NEWPATH" | tr ':' '\n' | sed 's|\.$||g' | grep -v "$HOME" | sort -u | grep -v '^$' | xargs -I{} echo "export PATH=\"\$PATH:{}\""
    printf 'export PATH+=.\n'
    return 0
  fi
  if [[ $1 = '--add' ]]; then
    shift 1
  elif [[ $1 = '--list' ]]; then
    shift 1
    echo "$PATH" | tr ":" "\n" | sort -u | grep -v "^$"
    return 0
  elif [[ "$1" = '--help' ]]; then
    __help
    return 1
  fi
  # Remove dir from path
  if [[ $1 = 'remove' ]] || [[ $1 = '--remove' ]] || [[ $1 = 'delete' ]] || [[ $1 = '--delete' ]]; then
    shift 1
    [[ $# -eq 0 || $1 = '--help' ]] && __help && return 1
    for args in "$@"; do
      [[ "$args" = '.' ]] && args=""
      if [[ -n "$args" ]]; then
        if [[ -n "$args" ]] && echo "$PATH" | tr ':' '\n' | grep -qsx "$args" &>/dev/null; then
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
    if [[ $# = 0 ]]; then
      if [[ -d "$PWD/bin" ]]; then
        if __test_path "$PWD/bin"; then
          printf "${red}%s is already in your PATH ${reset}\n" "$(realpath "$PWD/bin" 2>/dev/null)"
          return
        else
          PATH="$PWD/bin:$PATH"
          printf "${green}Added %s to your path ${reset}\n" "$(realpath "$PWD/bin" 2>/dev/null)"
          return
        fi
      else
        printf "${red}Not adding %s to path due to it not existing ${reset}\n" "$PWD/bin"
        return
      fi
    else
      for args in "$@"; do
        [[ "$args" = '.' ]] && args=""
        if [[ -n "$args" ]]; then
          if [[ -d "$args" ]]; then
            dir="$args"
          elif [[ -f "$args" ]]; then
            dir="$(dirname "$args" 2>/dev/null || echo '')"
          fi
          if [[ -d "$dir" ]]; then
            if __test_path; then
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
