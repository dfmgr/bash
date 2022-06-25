#!/usr/bin/env bash
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
##@Version       : 202108030255-git
# @Author        : casjay
# @Contact       : casjay
# @License       : LICENSE.md
# @ReadME        : fnm.bash --help
# @Copyright     : Copyright: (c) 2021 casjay, casjay
# @Created       : Tuesday, Aug 03, 2021 03:05 EDT
# @File          : fnm.bash
# @Description   : fast node manager
# @TODO          :
# @Other         :
# @Resource      : https://github.com/Schniz/fnm
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# Load fnm
[[ -n "$(builtin type fnm 2>/dev/null)" ]] && eval "$(fnm env)"
