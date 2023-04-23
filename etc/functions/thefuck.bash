# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
##@Version           :  202304231956-git
# @@Author           :  Jason Hempstead
# @@Contact          :  git-admin@casjaysdev.com
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
[ -z "$(type -p thefuck)" ] || eval $(thefuck --alias --enable-experimental-instant-mode)
