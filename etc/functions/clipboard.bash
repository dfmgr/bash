#!/usr/bin/env bash

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# @Author      : Jason
# @Contact     : casjaysdev@casjay.net
# @File        : clipboard.bash
# @Created     : Mon, Jan 6, 2021, 00:00 EST
# @License     : WTFPL
# @Copyright   : Copyright (c) CasjaysDev
# @Description : clipboard functions
#
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

if [[ "$OSTYPE" =~ ^darwin ]]; then
  [[ ! -n "$(command -v printclip)" ]] && printclip() { cmd_exists pbpaste && LC_CTYPE=UTF-8 tr -d "\n" | pbpaste || return 1; }
  [[ ! -n "$(command -v putclip)" ]] && putclip() { cmd_exists pbcopy && LC_CTYPE=UTF-8 tr -d "\n" | pbcopy || return 1; }
elif [[ "$OSTYPE" =~ ^linux ]]; then
  [[ ! -n "$(command -v printclip)" ]] && printclip() { cmd_exists xclip && xclip -o -s || return 1; }
  [[ ! -n "$(command -v putclip)" ]] && putclip() { cmd_exists xclip && xclip -i -sel c || return 1; }
fi
