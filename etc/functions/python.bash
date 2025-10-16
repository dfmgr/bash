# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
##@Version           :  202208122212-git
# @@Author           :  Jason Hempstead
# @@Contact          :  git-admin@casjaysdev.pro
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
setup_poetry() {
  curl -sSL https://install.python-poetry.org | python3 - --preview
  [ -n "$(builtin type -P poetry)" ] && poetry completions bash >"$HOME/.local/share/bash-completion/completions/poetry"
}
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
_activate_completion() {
  _init_completion || return
  local setv_env_dir="" venv_name="" venv_dir="${SETV_VIRTUAL_DIR_PATH:-$PWD}"
  venv_name="$(basename "$venv_dir")"
  setv_env_dir="$SETV_VIRTUAL_DIR_PATH/$venv_name"
  venv_dir="${setv_env_dir:-$venv_dir}"
  if [ -n "$SETV_VIRTUAL_DIR_PATH" ] && [ -d "$SETV_VIRTUAL_DIR_PATH" ]; then
    shopt -s nullglob
    local dirs=("$SETV_VIRTUAL_DIR_PATH"/*)
    shopt -u nullglob
    venv_projects="$(printf '%s\n' "${dirs[@]##*/}")"
  else
    venv_projects=""
  fi
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
  local setv_env_dir="" venv_name="" venv_dir=""
  if [ "$1" = "--help" ]; then
    printf_red "Usage: activate [name]"
    exit
  elif [ -f "$PWD/.venv_name" ]; then
    venv_dir="$(awk -F'=' '/VENV_VIRTUAL_DIR=/ {print $2; exit}' .venv_name)"
  elif [ -d "$PWD/.venv" ]; then
    venv_dir="$PWD/.venv"
    venv_name="$(basename "$PWD")"
  elif [ -d "$PWD/venv" ]; then
    venv_dir="$PWD/venv"
    venv_name="$(basename "$PWD")"
  elif [ -d "$SETV_VIRTUAL_DIR_PATH/$venv_name" ]; then
    setv_env_dir="$SETV_VIRTUAL_DIR_PATH/$venv_name"
  fi
  venv_dir="${setv_env_dir:-$venv_dir}"
  if [ -f "$venv_dir/bin/activate" ]; then
    . "$venv_dir/bin/activate"
  elif type setv &>/dev/null; then
    if setv -l | grep -vE 'List of virtual environments|^$' | grep -q "^"; then
      setv -l | grep -v '^$'
    fi

  fi
  return 0
} && export -f activate
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# end
