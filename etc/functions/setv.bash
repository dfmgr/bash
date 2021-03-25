#!/usr/bin/env bash
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
##@Version       : 202103251632-git
# @Author        : Sachin (psachin)
# @Contact       : iclcoolster@gmail.com
# @License       : GPLv3
# @ReadME        : setv --help
# @Copyright     : Copyright: (c) 2021 Sachin, psachin
# @Created       : Thursday, Mar 25, 2021 16:44 EDT
# @File          : setv.bash
# @Description   : A Lightweight Python virtual environment manager
# @TODO          :
# @Other         :
# @Resource      : https://psachin.gitlab.io/about
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# setV - A Lightweight Python virtual environment manager.
# Author: Sachin (psachin) <iclcoolster@gmail.com>
# Author's URL: https://psachin.gitlab.io/about
#
# License: GNU GPL v3, See LICENSE file
#
# Configure(Optional):
# Set `SETV_VIRTUAL_DIR_PATH` value to your virtual environments
# directory-path. By default it is set to '~/virtualenvs/'
#
# Usage:
# Manual install: Added below line to your .bashrc or any local rc script():
# ---
# source /path/to/virtual.sh
# ---
#
# Now you can 'activate' the virtual environment by typing
# $ setv <YOUR VIRTUAL ENVIRONMENT NAME>
#
# For example:
# $ setv rango
#
# or type:
# setv [TAB] [TAB]  (to list all virtual envs)
#
# To list all your virtual environments:
# $ setv --list
#
# To create new virtual environment:
# $ setv --new new_virtualenv_name
#
# To delete existing virtual environment:
# $ setv --delete existing_virtualenv_name
#
# To deactivate, type:
# $ deactivate

# Path to virtual environment directory
SETV_VIRTUAL_DIR_PATH="${SETV_VIRTUAL_DIR_PATH:-$HOME/.local/share/python/venvs/}"
# Default python version to use. This decides whether to use `virtualenv` or `python3 -m venv`
SETV_PYTHON_VERSION=3 # Defaults to Python3
SETV_PY_PATH=$(which python${SETV_PYTHON_VERSION})

function _setvcomplete_() {
  # Bash-autocompletion.
  # This ensures Tab-auto-completions work for virtual environment names.
  local cmd="${1##*/}" # to handle command(s).
  # Not necessary as such. 'setv' is the only command

  local word=${COMP_WORDS[COMP_CWORD]} # Words thats being completed
  local xpat='${word}'                 # Filter pattern. Include
  # only words in variable '$names'
  local names=$(ls -l "${SETV_VIRTUAL_DIR_PATH}" | grep -E '^d' | awk -F " " '{print $NF}') # Virtual environment names

  COMPREPLY=($(compgen -W "$names" -X "$xpat" -- "$word")) # compgen generates the results
}

function _setv_help_() {
  # Echo help/usage message
  echo "Usage: setv [OPTIONS] [NAME]"
  echo Positional argument:
  echo -e "NAME                       Activate virtual env."
  echo Optional arguments:
  echo -e "-l, --list                 List all Virtual Envs."
  echo -e "-n, --new NAME             Create a new Python Virtual Env."
  echo -e "-d, --delete NAME          Delete existing Python Virtual Env."
  echo -e "-p, --python PATH          Python binary path."
}

function _setv_custom_python_path() {
  if [ -f "${1}" ]; then
    if [ "$(expr $1 : '.*python\([2,3]\)')" = "3" ]; then
      SETV_PYTHON_VERSION=3
    else
      SETV_PYTHON_VERSION=2
    fi
    SETV_PY_PATH=${1}
    _setv_create $2
  else
    echo "Error: Path ${1} does not exist!"
  fi
}

function _setv_create() {
  # Creates new virtual environment if ran with -n|--new flag
  if [ -z ${1} ]; then
    echo "You need to pass virtual environment name"
    _setv_help_
  else
    echo "Creating new virtual environment with the name: $1"

    if [ ${SETV_PYTHON_VERSION} -eq 3 ]; then
      ${SETV_PY_PATH} -m venv ${SETV_VIRTUAL_DIR_PATH}${1}
    else
      virtualenv -p ${SETV_PY_PATH} ${SETV_VIRTUAL_DIR_PATH}${1}
    fi

    echo "You can now activate the Python virtual environment by typing: setv ${1}"
  fi
}

function _setv_delete() {
  # Deletes virtual environment if ran with -d|--delete flag
  # TODO: Refactor
  if [ -z ${1} ]; then
    echo "You need to pass virtual environment name"
    _setv_help_
  else
    if [ -d ${SETV_VIRTUAL_DIR_PATH}${1} ]; then
      read -p "Really delete this virtual environment(Y/N)? " yes_no
      case $yes_no in
      Y | y) rm -rvf ${SETV_VIRTUAL_DIR_PATH}${1} ;;
      N | n) echo "Leaving the virtual environment as it is." ;;
      *) echo "You need to enter either Y/y or N/n" ;;
      esac
    else
      echo "Error: No virtual environment found by the name: ${1}"
    fi
  fi
}

function _setv_list() {
  # Lists all virtual environments if ran with -l|--list flag
  echo -e "List of virtual environments you have under ${SETV_VIRTUAL_DIR_PATH}:\n"
  for virt in $(ls -l "${SETV_VIRTUAL_DIR_PATH}" | egrep '^d' | awk -F " " '{print $NF}'); do
    echo ${virt}
  done
}

function setv() {
  # Main function
  if [ $# -eq 0 ]; then
    _setv_help_
  elif [ $# -le 3 ]; then
    case "${1}" in
    -n | --new) _setv_create ${2} ;;
    -d | --delete) _setv_delete ${2} ;;
    -l | --list) _setv_list ;;
    *)
      if [ -d ${SETV_VIRTUAL_DIR_PATH}${1} ]; then
        # Activate the virtual environment
        source ${SETV_VIRTUAL_DIR_PATH}${1}/bin/activate
      else
        # Else throw an error message
        echo "Sorry, you don't have any virtual environment with the name: ${1}"
        _setv_help_
      fi
      ;;
    esac
  elif [ $# -le 5 ]; then
    case "${2}" in
    -p | --python) _setv_custom_python_path ${3} ${4} ;;
    *) _setv_help_ ;;
    esac
  fi
}

# Calls bash-complete. The compgen command accepts most of the same
# options that complete does but it generates results rather than just
# storing the rules for future use.
complete -F _setvcomplete_ setv
