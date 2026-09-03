#!/usr/bin/env bash
# shellcheck shell=bash
# shellcheck disable=SC2034 # palette vars are used via PS1 interpolation by callers
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
##@Version       : 202609031200-git
# @Author        : Jason Hempstead
# @Contact       : jason@casjaysdev.pro
# @License       : LICENSE.md
# @ReadME        : 00-powerline-colors.bash --help
# @Copyright     : Copyright: (c) 2026 Jason Hempstead, CasjaysDev
# @Created       : Thursday, Sep 03, 2026 12:00 EDT
# @File          : 00-powerline-colors.bash
# @Description   : Shared tput palette for 01-powerline.bash and 01-powerline.win
# @TODO          :
# @Other         :
# @Resource      :
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# quiets tput on terminals without the requested capability
__powerline_tput() { tput "$@" 2>/dev/null; }
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# sets FG_*/BG_*/DIM/REVERSE/RESET/BOLD in the caller's scope; not local
# on purpose, so both 01-powerline.bash and 01-powerline.win can call it
__powerline_colors() {
  FG_BLACK="\[$(__powerline_tput setaf 0)\]"
  FG_GRAY1="\[$(__powerline_tput setaf 15)\]"
  FG_GRAY2="\[$(__powerline_tput setaf 7)\]"
  FG_GRAY3="\[$(__powerline_tput setaf 8)\]"
  FG_RED="\[$(__powerline_tput setaf 9)\]"
  FG_GREEN="\[$(__powerline_tput setaf 10)\]"
  FG_YELLOW="\[$(__powerline_tput setaf 11)\]"
  FG_BLUE="\[$(__powerline_tput setaf 12)\]"
  FG_MAGENTA="\[$(__powerline_tput setaf 13)\]"
  FG_CYAN="\[$(__powerline_tput setaf 14)\]"
  FG_DARK_RED="\[$(__powerline_tput setaf 1)\]"
  FG_DARK_GREEN="\[$(__powerline_tput setaf 2)\]"
  FG_MUSTARD="\[$(__powerline_tput setaf 3)\]"
  FG_NAVY="\[$(__powerline_tput setaf 4)\]"
  FG_PURPLE="\[$(__powerline_tput setaf 5)\]"
  FG_TURQUOISE="\[$(__powerline_tput setaf 6)\]"
  BG_BLACK="\[$(__powerline_tput setab 0)\]"
  BG_GRAY1="\[$(__powerline_tput setab 15)\]"
  BG_GRAY2="\[$(__powerline_tput setab 7)\]"
  BG_GRAY3="\[$(__powerline_tput setab 8)\]"
  BG_RED="\[$(__powerline_tput setab 9)\]"
  BG_GREEN="\[$(__powerline_tput setab 10)\]"
  BG_YELLOW="\[$(__powerline_tput setab 11)\]"
  BG_BLUE="\[$(__powerline_tput setab 12)\]"
  BG_MAGENTA="\[$(__powerline_tput setab 13)\]"
  BG_CYAN="\[$(__powerline_tput setab 14)\]"
  BG_DARK_RED="\[$(__powerline_tput setab 1)\]"
  BG_DARK_GREEN="\[$(__powerline_tput setab 2)\]"
  BG_MUSTARD="\[$(__powerline_tput setab 3)\]"
  BG_NAVY="\[$(__powerline_tput setab 4)\]"
  BG_PURPLE="\[$(__powerline_tput setab 5)\]"
  BG_TURQUOISE="\[$(__powerline_tput setab 6)\]"
  BG_DEEP_GREEN="\[$(__powerline_tput setab 22)\]"
  DIM="\[$(__powerline_tput dim)\]"
  REVERSE="\[$(__powerline_tput rev)\]"
  RESET="\[$(__powerline_tput sgr0)\]"
  BOLD="\[$(__powerline_tput bold)\]"
}
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# end
