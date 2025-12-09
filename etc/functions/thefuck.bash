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
# @@Description      :  corrects errors in previous console commands
# @@Changelog        :  newScript
# @@TODO             :  Refactor code
# @@Other            :
# @@Resource         :  https://github.com/nvbn/thefuck
# @@Terminal App     :  no
# @@sudo/root        :  no
# @@Template         :  bash/system
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# Only initialize thefuck once per session (cached)
if [ -n "$(type -p thefuck 2>/dev/null)" ] && [ -z "$_THEFUCK_INITIALIZED" ]; then
  _THEFUCK_INITIALIZED=1
  eval "$(thefuck --enable-experimental-instant-mode --alias fuck 2>/dev/null)"
fi

