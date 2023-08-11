#!/usr/bin/env bash
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
##@Version       : 202111052257-git
# @Author        : Jason Hempstead
# @Contact       : jason@casjaysdev.pro
# @License       : WTFPL
# @ReadME        : chmod.bash --help
# @Copyright     : Copyright: (c) 2021 Jason Hempstead, Casjays Developments
# @Created       : Friday, Nov 05, 2021 22:57 EDT
# @File          : chmod.bash
# @Description   : chmod functions
# @TODO          :
# @Other         :
# @Resource      :
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
755d() { find ${1:-.} -type d -exec chmod -Rfv 755 {} \;; }
755f() { find ${1:-.} -type f -exec chmod -Rfv 755 {} \;; }
644f() { find ${1:-.} -type f -exec chmod -Rfv 644 {} \;; }
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# end
