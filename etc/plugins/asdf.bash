#!/usr/bin/env bash
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
##@Version           :  202208191109-git
# @@Author           :  jason
# @@Contact          :  jason@jasons-netbook
# @@License          :  LICENSE.md
# @@ReadME           :  asdf.bash --help
# @@Copyright        :  Copyright: (c) 2022 jason, 
# @@Created          :  Monday, Aug 22, 2022 00:59 EDT
# @@File             :  asdf.bash
# @@Description      :  asdf script manager
# @@Changelog        :  newScript
# @@TODO             :  Refactor code
# @@Other            :  
# @@Resource         :  
# @@Terminal App     :  no
# @@sudo/root        :  no
# @@Template         :  bash/profile
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# asdf
[ -f "$ASDF_DIR/asdf.sh" ] || return 0
if [ -n "$BASH_VERSION" ]; then
  . "$ASDF_DIR/asdf.sh"
fi
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
if [ -f "$ASDF_DIR/completions/asdf.bash" ]; then 
  . "$ASDF_DIR/completions/asdf.bash"
fi
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# end
