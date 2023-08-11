#!/usr/bin/env bash
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
##@Version       : 202103251632-git
# @Author        : Jason Hempstead
# @Contact       : jason@casjaysdev.pro
# @License       : LICENSE.md
# @ReadME        : tree.bash --help
# @Copyright     : Copyright: (c) 2021 Jason Hempstead, CasjaysDev
# @Created       : Thursday, Mar 25, 2021 17:57 EDT
# @File          : tree.bash
# @Description   :
# @TODO          :
# @Other         :
# @Resource      :
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
if ! type tree >&/dev/null; then
  tree() { # {{{
    opt=""
    directory="."
    while [ $# -gt 0 ]; do
      case $1 in
      "-L")
        opt="$opt -d $2"
        shift
        ;;
      "-d")
        opt="$opt -type d"
        shift
        ;;
      "-*")
        echo "$1 is invalid option"
        exit 1
        ;;
      "*")
        directory="$*"
        break
        ;;
      esac
      shift
    done
    find "$directory" $opt | sort | sed '1d;s,[^/]*/,|    ,g;s/..//;s/[^ ]*$/|-- &/'
  }
fi
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# end
