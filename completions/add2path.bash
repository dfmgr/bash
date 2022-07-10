#!/usr/bin/env bash
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
##@Version           :  202207042108-git
# @Author            :  Jason Hempstead
# @Contact           :  jason@casjaysdev.com
# @License           :  LICENSE.md
# @ReadME            :  add2path --help
# @Copyright         :  Copyright: (c) 2022 Jason Hempstead, Casjays Developments
# @Created           :  Saturday, Jul 09, 2022 20:37 EDT
# @File              :  add2path
# @Description       :
# @TODO              :
# @Other             :
# @Resource          :
# @sudo/root         :  no
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
_add2path_completion() {
  local i cur prev opts paths
  COMPREPLY=()
  cur="${COMP_WORDS[COMP_CWORD]}"
  prev="${COMP_WORDS[COMP_CWORD - 1]}"
  opts="--help --remove --add --list"
  paths="$(echo "$PATH" | tr ':' '\n' | sort -u | grep -v '^$' | grep '^')"
  if [[ ${prev} == '--help' ]]; then
    COMPREPLY=($(compgen -W '' -- ${cur}))
    return 0
  elif [[ ${prev} == 'remove' ]] || [[ ${prev} = '--remove' ]] || [[ ${prev} = 'delete' ]] || [[ ${prev} = '--delete' ]]; then
    COMPREPLY=($(compgen -W "${paths}" -- ${cur}))
    return
  elif [[ ${cur} == -* ]]; then
    COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
    return 0
  else
    _filedir -d
  fi
}
complete -F _add2path_completion add2path
