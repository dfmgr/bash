#!/usr/bin/env bash
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
##@Version       : 202111052337-git
# @Author        : Jason Hempstead
# @Contact       : jason@casjaysdev.pro
# @License       : WTFPL
# @ReadME        : projectdir_bin.bash --help
# @Copyright     : Copyright: (c) 2021 Jason Hempstead, Casjays Developments
# @Created       : Friday, Nov 05, 2021 23:37 EDT
# @File          : projectdir_bin.bash
# @Description   :
# @TODO          :
# @Other         :
# @Resource      :
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# prepends the nearest node_modules/.bin (., .., ../..) to PATH so
# project-local CLIs (eslint, jest, etc.) resolve without npx
set_project_path() {
  local dir bindir
  PROJECTDIR_BASH_PATH="${PROJECTDIR_BASH_PATH:-$PATH}"
  for dir in . .. ../..; do
    bindir="$PWD/$dir/node_modules/.bin"
    if [[ -d "$bindir" ]]; then
      bindir="$(cd "$bindir" && pwd)"
      PATH="$bindir:$PROJECTDIR_BASH_PATH"
      [[ "$1" == quiet ]] || echo "set_project_path(): \$PATH += $bindir" >&2
      return 0
    fi
  done
  return 1
}
# restores PATH to its value before the last set_project_path call
unset_project_path() {
  PATH="${PROJECTDIR_BASH_PATH:-$PATH}"
  unset PROJECTDIR_BASH_PATH
}
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
