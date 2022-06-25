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
command -v zoxide &>/dev/null && eval "$(zoxide init bash)" ||
  zoxide() { curl -q -sSL https://webinstall.dev/zoxide | bash; }
