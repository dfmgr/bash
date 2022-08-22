#!/usr/bin/env bash
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
##@Version       : 202108030344-git
# @Author        : Jason
# @Contact       : jason@casjaysdev.com
# @License       : WTFPL
# @ReadME        : zoxide --help
# @Copyright     : Copyright (c) 2021, Casjays Developments
# @Created       : Tuesday Aug 03, 2021 03:45:21 EDT
# @File          : zoxide
# @Description   :
# @TODO          :
# @Other         :
# @Resource      : https://github.com/ajeetdsouza/zoxide
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
if command -v zoxide &>/dev/null; then 
  eval "$(zoxide init bash)" 
else
  zoxide() { curl -q -LSsf "https://webinstall.dev/zoxide" | bash && eval "$(zoxide init bash)" || return 1; }
fi
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

