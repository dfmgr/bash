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
  opts="--help --remove --add"
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
    printf "\t\t%sOptions: add2path [--help] [--remove] [--list]%s\n" "${red}" "${reset}"
    printf "\t\t%sUsage: add2path [options] [directory]%s\n" "${red}" "${reset}"
  }
  local a=""
  local i=""
  local d=""
  local p=""
  local red="\033[0;31m"
  local green="\033[0;32m"
  local reset="\033[0m"
  local args=""
  [[ $# -eq 0 || $1 = '--help' ]] && __help && return 1
  if [[ $1 = '--add' ]]; then
    shift 1
  elif [[ $1 = '--list' ]]; then
    shift 1
    echo "$PATH" | tr ":" "\n" | sort -u | grep -v "^$"
    return 0
  fi
  if [[ $1 = 'remove' ]] || [[ $1 = '--remove' ]] || [[ $1 = 'delete' ]] || [[ $1 = '--delete' ]]; then
    shift 1
    for a in "$@"; do
      d="$(realpath "$a" 2>/dev/null)"
      if [[ -d "$d" ]]; then
        p="$d"
      else
        p="$(dirname "$d")"
      fi
      [[ -n "$p" ]] || continue
      if echo "$PATH" | tr ':' '\n' | grep -sqw "$d" &>/dev/null; then
        p="$(echo "$PATH" | tr ':' '\n' | grep -v "$d" | grep -v '^$' | tr '\n' ':')"
        export PATH="$p"
        printf "\t\t${green}Deleted %s from PATH ${reset}\n" "$p"
      else
        printf "\t\t${red}%s not found in PATH ${reset}\n" "$p"
      fi
    done
  else
    while :; do
      echo "$@" | grep -q '\-' &>/dev/null && break
      [[ $1 = -* ]] && shift 1 && echo 'Do not provide any arguments'
    done
    for a in "$@"; do
      d="$(realpath "$a" 2>/dev/null)"
      if [[ -d "$d" ]]; then
        p="$d"
        if [[ -n "$p" ]]; then
          if echo "$PATH" | tr ':' '\n' | grep -sqw "$p" &>/dev/null; then
            printf "\t\t${red}%s is already in your PATH ${reset}\n" "$p"
          else
            export PATH="$p:$PATH"
            printf "\t\t${green}Added %s to PATH ${reset}\n" "$p"
          fi
        fi
      elif [[ -e "$d" ]]; then
        p="$(dirname "$i")"
        if [[ -n "$p" ]]; then
          if echo "$PATH" | tr ':' '\n' | grep -sqw "$p" &>/dev/null; then
            printf "\t\t${red}%s is already in your PATH ${reset}\n" "$p"
          else
            export PATH="$p:$PATH"
            printf "\t\t${green}Added %s to PATH ${reset}\n" "$p"
          fi
        else
          printf "\t\t${red}%s does not exist ${reset}\n" "$p"
        fi
      fi
    done
  fi
  return ${exitCode:-$?}
}
