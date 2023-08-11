#!/usr/bin/env bash
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
##@Version           :  202304232004-git
# @@Author           :  Jason Hempstead
# @@Contact          :  git-admin@casjaysdev.pro
# @@License          :  LICENSE.md
# @@ReadME           :  find.bash --help
# @@Copyright        :  Copyright: (c) 2023 Jason Hempstead, Casjays Developments
# @@Created          :  Sunday, Apr 23, 2023 21:53 EDT
# @@File             :  find.bash
# @@Description      :  Custom find function to exclude .git directories
# @@Changelog        :  newScript
# @@TODO             :  Refactor code
# @@Other            :
# @@Resource         :
# @@Terminal App     :  no
# @@sudo/root        :  no
# @@Template         :  bash/system
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
find_file() { $(\builtin type -P find) -L "$@" -type ${FIND_DEFAULT_TYPE:-f} -not -path '*/\.git/*' -not -path '*/\.svn/*' -not -path '*/\.hg/*' 2>/dev/null || return 1; }
