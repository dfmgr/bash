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
_venv_completion() { 
  local venv_name="" venv_dir="" venv_projects=""
  local SETV_VIRTUAL_DIR_PATH="${SETV_VIRTUAL_DIR_PATH:-$VENV_DIR}"
  venv_name="$(basename "$PWD")"                 
  venv_dir="${SETV_VIRTUAL_DIR_PATH/$venv_name:-$PWD/.venv}"
  [ -f "$PWD/.venv_name" ] && venv_dir="$(<"$PWD/.venv_name")" 
  venv_projects="$([ -n "$SETV_VIRTUAL_DIR_PATH" ] && find "$SETV_VIRTUAL_DIR_PATH/" -maxdepth 1 -type d -printf "%P\n" 2>/dev/null | grep  -v '^$' || echo '')"
  #[ "$word" = "delete" ] && COMPREPLY=($(compgen -W '${venv_projects}' -- "$cur"))
  if [ -n "$VIRTUAL_ENV" ]; then
    COMPREPLY=($(compgen -W 'deactivate' -- "$cur"))
  elif [ -f "$venv_dir/bin/activate" ]; then
    COMPREPLY=($(compgen -W 'activate delete"' -- "$cur")) 
  elif [ -n "$venv_projects" ]; then
    COMPREPLY=($(compgen -W 'create delete ${venv_projects}' -- "$cur"))
  fi
} && complete -F _venv_completion -o default venv activate
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
venv() {
  local venv_name="" venv_dir=""
  local SETV_VIRTUAL_DIR_PATH="${SETV_VIRTUAL_DIR_PATH:-$VENV_DIR}"
  venv_name="$(basename "$PWD")"
  venv_dir="${SETV_VIRTUAL_DIR_PATH/$venv_name:-$PWD/.venv}"
  pythonbin="$(builtin type -P /usr/local/bin/python3 || builtin type -P /usr/bin/python3 || false)"
  [ -f "$PWD/.venv_name" ] && venv_dir="$(<"$PWD/.venv_name")"
  builtin type -P python3 &>/dev/null || return 1
  if [ -z "$VIRTUAL_ENV" ]; then
    if $pythonbin -m virtualenv 2>&1 |& grep -q 'No module named'; then 
      printf_blue "Attempting to install the virtualenv module"
      eval $pythonbin -m pip install --user virtualenv &>/dev/null || return 1
    fi
  fi
  if [ "$1" = activate ] && [ -f "$venv_dir/bin/activate" ]; then
    shift 1
    . "$venv_dir/bin/activate"
  elif [ "$1" = "deactivate" ] && [ -n "$VIRTUAL_ENV" ]; then
    deactivate
  elif [ "$1" = "delete" ] && [ -d "$venv_dir/$2" ]; then
    printf_purple "Deleting $venv_dir/$2"
    rm -Rf "$venv_dir/$2"
    [ -d "$venv_dir/$2" ] && printf_red "Failed to delete $2" || printf_green "Deleted the environment $2"
  else
    [ -n "$VIRTUAL_ENV" ] && printf_yellow "A virtual environment is already active" && return
    [ "$1" = "create" ] && shfit 1
    [ -n "$1" ] && venv_dir="$1" && echo "$venv_dir" > "$PWD/.venv_name"
    [ -d "$venv_dir" ] && printf_red "$venv_name already exists" && return 1
    printf_cyan "Creating a new environment for $venv_name"
    $pythonbin -m venv "$venv_dir" &>/tmp/$venv_name.log && [ -f "$venv_dir/bin/activate" ] && "$venv_dir/bin/activate" && 
      printf_green "virtual environment has been initiated" ||
      { printf_red "Failed to initiate the virtual environment" && printf_yellow "in: $venv_dir" && return 1; } 
  fi
  return 0
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
