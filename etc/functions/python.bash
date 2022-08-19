# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
##@Version           :  202208122212-git
# @@Author           :  Jason Hempstead
# @@Contact          :  git-admin@casjaysdev.com
# @@License          :  LICENSE.md
# @@ReadME           :  activate --help
# @@Copyright        :  Copyright: (c) 2022 Jason Hempstead, Casjays Developments
# @@Created          :  Friday, Aug 19, 2022 04:42 EDT
# @@File             :  activate
# @@Description      :  activate a python virtual environment
# @@Changelog        :  newScript
# @@TODO             :  Refactor code
# @@Other            :  
# @@Resource         :  
# @@Terminal App     :  no
# @@sudo/root        :  no
# @@Template         :  none
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
_activate_completion() { 
  _init_completion || return
  local list=""
  list="$(setv -l | grep -vE 'List of virtual environments|^$' | grep "^" || echo '')"
  COMPREPLY=($(compgen -W '${list}' -- "$cur"))
}
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
activate() {
  if [ -f "$PWD/.venv/bin/activate" ]; then
    . "$PWD/.venv/bin/activate"
  elif type setv &>/dev/null; then
    if setv -l | grep -vE 'List of virtual environments|^$' | grep -q "$1"; then
      setv "$1" || return 1
    fi
  #else
  #  type deactivate &>/dev/null && deactivate || unset 
  fi
  return 0
} && export -f activate
