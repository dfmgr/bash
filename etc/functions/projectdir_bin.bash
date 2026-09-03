#!/usr/bin/env bash
# shellcheck shell=bash
# - - - - - - - - - - - - - - - - - - - - - - - -
##@Version           :  202609031422-git
# @@Author           :  Jason Hempstead
# @@Contact          :  git-admin@casjaysdev.pro
# @@License          :  WTFPL
# @@ReadME           :  README.md
# @@Copyright        :  Copyright: (c) 2021 Jason Hempstead, Casjays Developments
# @@Created          :  Friday, Nov 05, 2021 23:37 EDT
# @@File             :  projectdir_bin.bash
# @@Description      :  prepend the nearest node_modules/.bin to PATH for project-local CLIs
# @@Changelog        :  standardized header to WTFPL @@-field template
# @@TODO             :
# @@Other            :
# @@Resource         :
# @@Terminal App     :  no
# @@sudo/root        :  no
# @@Template         :  shell/bash
# - - - - - - - - - - - - - - - - - - - - - - - -
# shellcheck disable=SC1001,SC1003,SC2001,SC2003,SC2016,SC2031,SC2090,SC2115,SC2120,SC2155,SC2199,SC2229,SC2317,SC2329
# - - - - - - - - - - - - - - - - - - - - - - - -
VERSION="202609031422-git"
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
