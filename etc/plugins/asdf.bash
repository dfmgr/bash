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
if [ -n "$BASH_VERSION" ] && [ -n "$ASDF_DIR" ]; then
  [ -f "$ASDF_DIR/asdf.sh" ] && . "$ASDF_DIR/asdf.sh"
  [ -f "$ASDF_DIR/completions/asdf.bash" ] && . "$ASDF_DIR/completions/asdf.bash"
fi
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# end
