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
_add2path_completion() {
  local i cur prev opts paths
  COMPREPLY=()
  cur="${COMP_WORDS[COMP_CWORD]}"
  prev="${COMP_WORDS[COMP_CWORD - 1]}"
  opts="--help --remove --add --list"
  paths="$(echo "$PATH" | tr ':' '\n' | sort -u | grep -v '^$')"
  if [[ ${prev} == '--help' ]]; then
    COMPREPLY=($(compgen -W '' -- ${cur}))
    return 0
  elif [[ ${prev} == 'remove' ]] || [[ ${prev} = '--remove' ]] || [[ ${prev} = 'delete' ]] || [[ ${prev} = '--delete' ]]; then
    COMPREPLY=($(compgen -W "${paths}" -- ${cur}))
    return
  elif [[ ${cur} == -* ]]; then
    COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
    return 0
  else
    _filedir -d
  fi
}
complete -F _add2path_completion add2path

add2path() {
  __help() {
    printf "\t\t%s\n" "${red}Options: add2path [--add] [--help] [--remove] [--list]${reset}"
    printf "\t\t%s\n" "${green}Usage: add2path [options] [directory]${reset}"
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
          printf "\t\t${green}Deleted %s from PATH ${reset}\n" "$args"
        else
          printf "\t\t${red}%s was not not found in PATH ${reset}\n" "$args"
        fi
      else
        printf "\t\t${red}An error has occured %s${reset}\n" "$args"
      fi
    done
  else
    # Add dir to path
    [[ $# -eq 0 || $1 = '--help' ]] && __help && return 1
    for args in "$@"; do
      [[ "$args" = '.' ]] && args=""
      if [[ -n "$args" ]]; then
        if [[ -d "$args" ]]; then
          dir="$args"
        elif [[ -f "$args" ]]; then
          dir="$(dirname "$args" 2>/dev/null || echo '')"
        fi
        if [[ -d "$dir" ]]; then
          if echo "$PATH" | tr ':' '\n' | grep -qsx "$dir" &>/dev/null; then
            printf "\t\t${red}%s is already in your PATH ${reset}\n" "$(realpath "$dir" 2>/dev/null)"
          else
            path="$dir:$PATH"
            export PATH="$path"
            printf "\t\t${green}Added %s to your path ${reset}\n" "$(realpath "$dir" 2>/dev/null)"
          fi
        else
          printf "\t\t${red}Not adding %s to path due to it not existing ${reset}\n" "$args"
        fi
      else
        printf "\t\t${red}An error has occured %s${reset}\n" "$args"
      fi
    done
  fi
  return ${exitCode:-$?}
}
