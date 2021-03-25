#!/usr/bin/env bash
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
