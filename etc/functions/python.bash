#!/usr/bin/env bash
# shellcheck shell=bash
# - - - - - - - - - - - - - - - - - - - - - - - -
##@Version           :  202609031422-git
# @@Author           :  Jason Hempstead
# @@Contact          :  git-admin@casjaysdev.pro
# @@License          :  WTFPL
# @@ReadME           :  README.md
# @@Copyright        :  Copyright: (c) 2022 Jason Hempstead, Casjays Developments
# @@Created          :  Friday, Aug 19, 2022 04:42 EDT
# @@File             :  python.bash
# @@Description      :  activate a python virtual environment
# @@Changelog        :  standardized header to WTFPL @@-field template
# @@TODO             :  Refactor code
# @@Other            :
# @@Resource         :
# @@Terminal App     :  no
# @@sudo/root        :  no
# @@Template         :  shell/bash
# - - - - - - - - - - - - - - - - - - - - - - - -
# shellcheck disable=SC1001,SC1003,SC2001,SC2003,SC2016,SC2031,SC2090,SC2115,SC2120,SC2155,SC2199,SC2229,SC2317,SC2329
# - - - - - - - - - - - - - - - - - - - - - - - -
VERSION="202609031422-git"
setup_poetry() {
  curl -sSL https://install.python-poetry.org | python3 - --preview
  [ -n "$(builtin type -P poetry)" ] && poetry completions bash >"$HOME/.local/share/bash-completion/completions/poetry"
}
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# shellcheck disable=SC2154  # cur is populated by _init_completion
_activate_completion() {
  _init_completion || return
  local setv_env_dir="" venv_name="" venv_dir="${SETV_VIRTUAL_DIR_PATH:-$PWD}"
  venv_name="${venv_dir##*/}"
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
    mapfile -t COMPREPLY < <(compgen -W 'deactivate' -- "$cur")
  elif [ -n "$venv_projects" ]; then
    mapfile -t COMPREPLY < <(compgen -W "--help ${venv_projects}" -- "$cur")
  else
    mapfile -t COMPREPLY < <(compgen -W '--help' -- "$cur")
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
    venv_name="${PWD##*/}"
  elif [ -d "$PWD/venv" ]; then
    venv_dir="$PWD/venv"
    venv_name="${PWD##*/}"
  elif [ -d "$SETV_VIRTUAL_DIR_PATH/$venv_name" ]; then
    setv_env_dir="$SETV_VIRTUAL_DIR_PATH/$venv_name"
  fi
  venv_dir="${setv_env_dir:-$venv_dir}"
  if [ -f "$venv_dir/bin/activate" ]; then
    # shellcheck source=/dev/null
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
