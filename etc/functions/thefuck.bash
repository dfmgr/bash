#!/usr/bin/env bash
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
##@Version           :  202304231956-git
# @@Author           :  Jason Hempstead
# @@Contact          :  git-admin@casjaysdev.pro
# @@License          :  WTFPL
# @@ReadME           :  fuck.bash --help
# @@Copyright        :  Copyright: (c) 2023 Jason Hempstead, Casjays Developments
# @@Created          :  Sunday, Apr 23, 2023 19:56 EDT
# @@File             :  fuck.bash
# @@Description      :  corrects errors in previous console commands (lazy loaded)
# @@Changelog        :  newScript
# @@TODO             :  Refactor code
# @@Other            :
# @@Resource         :  https://github.com/nvbn/thefuck
# @@Terminal App     :  no
# @@sudo/root        :  no
# @@Template         :  bash/system
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# Lazy load thefuck - only load when fuck command is actually used
# This improves shell startup time significantly (thefuck is slow to init)
if command -v thefuck >/dev/null 2>&1; then
  fuck() {
    unset -f fuck 2>/dev/null
    eval "$(thefuck --enable-experimental-instant-mode --alias fuck)"
    fuck "$@"
  }
fi
