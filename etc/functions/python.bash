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
  local setv_env_dir="" venv_name="" venv_dir="${SETV_VIRTUAL_DIR_PATH:-$PWD}"
  venv_name="$(basename "$venv_dir")"
  setv_env_dir="$SETV_VIRTUAL_DIR_PATH/$venv_name"
  venv_dir="${setv_env_dir:-$venv_dir}"
  venv_projects="$([ -n "$SETV_VIRTUAL_DIR_PATH" ] && find "$SETV_VIRTUAL_DIR_PATH/" -maxdepth 1 -type d -printf "%P\n" 2>/dev/null | grep -v '^$' || echo '')"
  if [ -n "$VIRTUAL_ENV" ]; then
    COMPREPLY=($(compgen -W 'deactivate' -- "$cur"))
  elif [ -n "$venv_projects" ]; then
    COMPREPLY=($(compgen -W '--help ${venv_projects}' -- "$cur"))
  else
    COMPREPLY=($(compgen -W '--help' -- "$cur"))
  fi
} && complete -F _activate_completion activate
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
activate() {
  [ "$1" = "--help" ] && { printf_red "Usage: activate" && return || return 0; }
  local setv_env_dir="" venv_name="" venv_dir="${venv_dir:-$PWD}"
  venv_name="$(basename "$PWD")"
  setv_env_dir="$SETV_VIRTUAL_DIR_PATH/$venv_name"
  venv_dir="${setv_env_dir:-$venv_dir}"
  [ -f "$PWD/.venv_name" ] && venv_dir="$(. "$PWD/.venv_name")"
  if [ -f "$venv_dir/bin/activate" ]; then
    . "$venv_dir/bin/activate"
  elif type setv &>/dev/null; then
    if setv -l | grep -vE 'List of virtual environments|^$' | grep -q "^"; then
      setv -l | grep -v '^$'
    fi

  fi
  return 0
} && export -f activate
