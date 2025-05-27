#!/usr/bin/env bash
# shellcheck shell=bash
# shellcheck disable=SC2317
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
##@Version           :  202207161759-git
# @@Author           :  Jason Hempstead
# @@Contact          :  jason@casjaysdev.pro
# @@License          :  WTFPL
# @@ReadME           :  noprompt.bash --help
# @@Copyright        :  Copyright: (c) 2022 Jason Hempstead, Casjays Developments
# @@Created          :  Saturday, Jul 16, 2022 17:59 EDT
# @@File             :  noprompt.bash
# @@Description      :  set the bash prompt
# @@Changelog        :
# @@TODO             :
# @@Other            :
# @@Resource         :
# @@sudo/root        :  no
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# Disable/enablr the bash prompt versions
noprompt() {
  local setopts=""
  local action="touch"
  local message="Disabled"
  local shortopts="e,s,d"
  local longopts="enable,show,disable,help,disable-all,enable-all"
  local array="date git go lua node path perl php python reminder ruby rust timer wakatime bashprompt"
  [ -d "$HOME/.config/bash/noprompt" ] || mkdir -p "$HOME/.config/bash/noprompt"
  setopts=$(getopt -o "$shortopts" --long "$longopts" -a -n "noprompt" -- "$@" 2>/dev/null)
  eval set -- "${setopts[@]}" 2>/dev/null
  while :; do
    case "$1" in
    --disable | -d)
      shift 1
      ;;
    --enable | -e | -s)
      shift 1
      action="rm -Rf"
      message="Enabled"
      ;;
    --help)
      shift 1
      printf_blue "Disable prompt messages"
      printf_blue "${array}"
      return
      ;;
    --disable-all)
      shift 1
      for f in ${array}; do
        printf_blue "Disabled ${f}"
        touch "$HOME/.config/bash/noprompt/$f"
      done
      if [ -f "${BASH_SOURCE[0]}" ]; then
        printf "${GREEN}Updating prompt from: %s\n" "${BASH_SOURCE[0]}"
        exec bash -s "${BASH_SOURCE[0]}"
      fi
      return
      ;;
    --enable-all)
      shift 1
      for f in ${array}; do
        printf_blue "Enabled ${f}"
        [ -f "$HOME/.config/bash/noprompt/$f" ] && rm -Rf "$HOME/.config/bash/noprompt/$f"
      done
      if [ -f "${BASH_SOURCE[0]}" ]; then
        printf "${GREEN}Updating prompt from: %s\n" "${BASH_SOURCE[0]}"
        exec bash -s "${BASH_SOURCE[0]}"
      fi
      return
      ;;
    --show)
      shift 1
      for f in ${array}; do
        [ -f "$HOME/.config/bash/noprompt/$f" ] && printf_yellow "$f is disabled" || printf_green "$f is enabled"
      done
      ;;
    --)
      shift 1
      break
      ;;
    esac
  done
  [ $# -eq 0 ] && return
  while :; do
    case "$1" in
    date | time) $action "$HOME/.config/bash/noprompt/date" ;;
    git) $action "$HOME/.config/bash/noprompt/git" ;;
    go) $action "$HOME/.config/bash/noprompt/go" ;;
    lua) $action "$HOME/.config/bash/noprompt/lua" ;;
    node) $action "$HOME/.config/bash/noprompt/node" ;;
    path) $action "$HOME/.config/bash/noprompt/path" ;;
    perl) $action "$HOME/.config/bash/noprompt/perl" ;;
    php) $action "$HOME/.config/bash/noprompt/php" ;;
    python) $action "$HOME/.config/bash/noprompt/python" ;;
    reminder) $action "$HOME/.config/bash/noprompt/git_reminder" ;;
    ruby) $action "$HOME/.config/bash/noprompt/ruby" ;;
    rust) $action "$HOME/.config/bash/noprompt/rust" ;;
    timer) $action "$HOME/.config/bash/noprompt/timer" ;;
    wakatime) $action "$HOME/.config/bash/noprompt/wakatime" ;;
    bashprompt)
      if [ $message = "Enabled" ]; then
        if [ -f "HOME/.config/bash/noprompt/powerline_ps1" ]; then
          unset PROMPT_COMMAND PS1
          mv -f "HOME/.config/bash/noprompt/powerline_ps1" "$HOME/.config/bash/prompt/01-powerline.bash"
          . "$HOME/.config/bash/prompt/01-powerline.bash"
        fi
      else
        if [ -f "$HOME/.config/bash/prompt/01-powerline.bash" ]; then
          unset PROMPT_COMMAND PS1 PS2 PS3 PS4
          mv -f "$HOME/.config/bash/prompt/01-powerline.bash" "$HOME/.config/bash/noprompt/powerline_ps1"
          [ -n "$(type -P starship)" ] && eval "$(starship init --print-full-init bash)"
        fi
      fi
      ;;
    esac
    printf_blue "$message $1"
    shift 1
    [ $# -ne 0 ] || break
  done
  if [ -f "${BASH_SOURCE[0]}" ]; then
    printf "${GREEN}Updating prompt from: %s\n" "${BASH_SOURCE[0]}"
    exec bash -s "${BASH_SOURCE[0]}"
  fi
  return
}
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
