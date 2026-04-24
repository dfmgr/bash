#!/usr/bin/env bash
# shellcheck shell=bash
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
##@Version       : 202305030938-git
# @Author        : Jason Hempstead
# @Contact       : jason@casjaysdev.pro
# @License       : LICENSE.md
# @ReadME        : zzzz-import.bash --help
# @Copyright     : Copyright: (c) 2023 Jason Hempstead, CasjaysDev
# @Created       : Monday, May 08, 2023 19:52 EDT
# @File          : zzzz-import.bash
# @Description   : Sources global shell functions from ~/.config/misc
# @TODO          : Refactor code
# @Other         :
# @Resource      :
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# shellcheck source=/dev/null
[ -f "$HOME/.config/misc/shell/functions/global.sh" ] && . "$HOME/.config/misc/shell/functions/global.sh"
