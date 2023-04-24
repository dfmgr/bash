#!/usr/bin/env bash
# shellcheck shell=bash
# shellcheck disable=SC2317
# shellcheck disable=SC2120
# shellcheck disable=SC2155
# shellcheck disable=SC2199
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
##@Version           :  202304232249-git
# @@Author           :  Jason Hempstead
# @@Contact          :  jason@casjaysdev.com
# @@License          :  LICENSE.md
# @@ReadME           :  install.sh --help
# @@Copyright        :  Copyright: (c) 2023 Jason Hempstead, Casjays Developments
# @@Created          :  Sunday, Apr 23, 2023 23:38 EDT
# @@File             :  install.sh
# @@Description      :  Install configurations for bash
# @@Changelog        :  New script
# @@TODO             :  Better documentation
# @@Other            :
# @@Resource         :
# @@Terminal App     :  no
# @@sudo/root        :  no
# @@Template         :  installers/dfmgr
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
APPNAME="bash"
VERSION="202304232249-git"
HOME="${USER_HOME:-$HOME}"
USER="${SUDO_USER:-$USER}"
RUN_USER="${SUDO_USER:-$USER}"
SCRIPT_SRC_DIR="${BASH_SOURCE%/*}"
export SCRIPTS_PREFIX="dfmgr"
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# Set bash options
trap 'retVal=$?;trap_exit' ERR EXIT SIGINT
#if [ ! -t 0 ] && { [ "$1" = --term ] || [ $# = 0 ]; }; then { [ "$1" = --term ] && shift 1 || true; } && TERMINAL_APP="TRUE" myterminal -e "$APPNAME $*" && exit || exit 1; fi
[ "$1" = "--debug" ] && set -x && export SCRIPT_OPTS="--debug" && export _DEBUG="on"
[ "$1" = "--raw" ] && export SHOW_RAW="true"
set -o pipefail
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# Import functions
CASJAYSDEVDIR="${CASJAYSDEVDIR:-/usr/local/share/CasjaysDev/scripts}"
SCRIPTSFUNCTDIR="${CASJAYSDEVDIR:-/usr/local/share/CasjaysDev/scripts}/functions"
SCRIPTSFUNCTFILE="${SCRIPTSAPPFUNCTFILE:-mgr-installers.bash}"
SCRIPTSFUNCTURL="${SCRIPTSAPPFUNCTURL:-https://github.com/dfmgr/installer/raw/main/functions}"
connect_test() { curl -q -ILSsf --retry 1 -m 1 "https://1.1.1.1" | grep -iq 'server:*.cloudflare' || return 1; }
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
if [ -f "$PWD/$SCRIPTSFUNCTFILE" ]; then
  . "$PWD/$SCRIPTSFUNCTFILE"
elif [ -f "$SCRIPTSFUNCTDIR/$SCRIPTSFUNCTFILE" ]; then
  . "$SCRIPTSFUNCTDIR/$SCRIPTSFUNCTFILE"
elif connect_test; then
  curl -q -LSsf "$SCRIPTSFUNCTURL/$SCRIPTSFUNCTFILE" -o "/tmp/$SCRIPTSFUNCTFILE" || exit 1
  . "/tmp/$SCRIPTSFUNCTFILE"
else
  echo "Can not load the functions file: $SCRIPTSFUNCTDIR/$SCRIPTSFUNCTFILE" 1>&2
  exit 90
fi
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# Define pre-install scripts
__run_pre_install() {

  return ${?:-0}
}
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# Define custom functions

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# Call the main function
dfmgr_install
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# trap the cleanup function
trap_exit
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# OS Support: supported_os unsupported_oses
unsupported_oses
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# Make sure the scripts repo is installed
scripts_check
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# Defaults
APPNAME="${APPNAME:-install.sh}"
APPDIR="$CONF/$APPNAME"
INSTDIR="$CASJAYSDEVSHARE/dfmgr/$APPNAME"
REPO_BRANCH="${GIT_REPO_BRANCH:-main}"
REPO="${DFMGR:-https://github.com/dfmgr}/$APPNAME"
REPORAW="$REPO/raw/$REPO_BRANCH"
APPVERSION="$(__appversion "$REPORAW/version.txt")"
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# Setup plugins
PLUGIN_REPOS="https://github.com/Bash-it/bash-it"
PLUGIN_DIR="${SHARE:-$HOME/.local/share}/$APPNAME/plugins"
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# Export variables

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# Require a version higher than
dfmgr_req_version "$APPVERSION"
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# Script options IE: --help --version
show_optvars "$@"
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# Do not update
#installer_noupdate "$@"
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# Requires root - no point in continuing
#sudoreq "$0 *" # sudo required
#sudorun "$0 *" # sudo optional
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# Initialize the installer
dfmgr_run_init
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# Run pre-install commands
execute "__run_pre_install" "Running pre-installation commands"
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# end with a space
APP="$APPNAME "
AUR=""
PERL=""
PYTH=""
PIPS=""
CPAN=""
GEMS=""
NPM=""
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# install required packages using the aur - Requires yay to be installed
install_aur "$AUR"
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# install packages - useful for package that have the same name on all oses
install_packages "$APP"
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# install required packages using file
install_required "$APP"
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# check for perl modules and install using system package manager
install_perl "$PERL"
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# check for python modules and install using system package manager
install_python "$PYTH"
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# check for pip binaries and install using python package manager
install_pip "$PIPS"
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# check for cpan binaries and install using perl package manager
install_cpan "$CPAN"
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# check for ruby binaries and install using ruby package manager
install_gem "$GEMS"
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# check for npm binaries and install using node package manager
install_npm "$NPM"
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# Other dependencies
dotfilesreq
dotfilesreqadmin
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# Ensure directories exist
ensure_dirs
ensure_perms
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# Backup if needed
if [ -d "$APPDIR" ]; then
  execute "backupapp $APPDIR $APPNAME" "Backing up $APPDIR"
fi
# Main progam
if __am_i_online; then
  if [ -d "$INSTDIR/.git" ]; then
    execute "git_update $INSTDIR" "Updating $APPNAME configurations"
  else
    execute "git_clone $REPO $INSTDIR" "Installing $APPNAME configurations"
  fi
  # exit on fail
  failexitcode $? "Git has failed"
fi
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# Custom plugin function
__custom_plugin() {
  local exitCodeC=0

  return $exitCodeC
}
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# Install Plugins
if __am_i_online; then
  if [ "$PLUGIN_REPOS" != "" ]; then
    exitCodeP=0
    [ -d "$PLUGIN_DIR" ] || mkdir -p "$PLUGIN_DIR"
    for plugin in $PLUGIN_REPOS; do
      plugin_name="$(basename "$plugin")"
      plugin_dir="$PLUGIN_DIR/$plugin_name"
      if [ -d "$plugin_dir/.git" ]; then
        execute "git_update $plugin_dir" "Updating plugin $plugin_name"
        [ $? -ne 0 ] && exitCodeP=$(($? + exitCodeP)) && printf_red "Failed to update $plugin_name"
      else
        execute "git_clone $plugin $plugin_dir" "Installing plugin $plugin_name"
        [ $? -ne 0 ] && exitCodeP=$(($? + exitCodeP)) && printf_red "Failed to install $plugin_name"
      fi
    done
  fi
  __custom_plugin
  exitCodeP=$(($? + exitCodeP))
  # exit on fail
  failexitcode $exitCodeP "Installation of plugin failed"
fi
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# run before primary post install function
__run_prepost_install() {
  history -r &>/dev/null && history -a &>/dev/null && history -w &>/dev/null && history -r &>/dev/null && history -a &>/dev/null
  [ -f "$APPDIR/welcome.msg" ] && WELCOME="true"
  [ -d "$HOME/.local/bin" ] || mkdir -p "$HOME/.local/bin"
  [ -d "$HOME/.config/bash" ] || mkdir -p "$HOME/.config/bash"
  [ -f "$HOME/.config/bash/bash_history" ] && mv_f "$HOME/.config/bash/bash_history" "/tmp/bash_history.tmp"
  for file in aliases bash_logout bash_profile bashrc completions exports plugins profile prompt; do
    rm_rf "$APPDIR/$file"
  done
  [ ! -f "$COMPDIR/README.md" ] || rm_rf "$COMPDIR/README.md"
  [ -z "$WELCOME" ] || touch "$APPDIR/welcome.msg"
  if [ -f "$HOME/.bash_history" ] && [ ! -e "HOME/.config/bash/bash_history" ]; then
    mv -f "$HOME/.bash_history" "$HOME/.config/bash/bash_history"
  elif [ -f "$HOME/.bash_history" ] && [ -e "HOME/.config/bash/bash_history" ]; then
    cat "$HOME/.bash_history" >>"$HOME/.config/bash/bash_history"
    rm -Rf "$HOME/.bash_history"
  elif [ -f "/tmp/bash_history.tmp" ]; then
    mv -f "/tmp/bash_history.tmp" "$HOME/.config/bash/bash_history"
  fi
  return 0
}
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# run after primary post install function
__run_post_install() {
  touch "$HOME/.config/bash/bash_history"
  [ -f "$APPDIR/bashrc" ] && . "$APPDIR/bashrc"
  [ ! -f "$APPDIR/bashrc" ] || ln_sf "$APPDIR/bashrc" "$HOME/.bashrc"
  [ ! -f "$APPDIR/bash_logout" ] || ln_sf "$APPDIR/bash_logout" "$HOME/.bash_logout"
  [ ! -f "$APPDIR/bash_profile" ] || ln_sf "$APPDIR/bash_profile" "$HOME/.bash_profile"
  history -r &>/dev/null && history -a &>/dev/null && history -w &>/dev/null && history -r &>/dev/null && history -a &>/dev/null
  return 0
}
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# run post install scripts
run_postinst() {
  __run_prepost_install
  dfmgr_run_post
  __run_post_install
}
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# run post install scripts
execute "run_postinst" "Running post install scripts"
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# Output post install message

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# create version file
dfmgr_install_version
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# run exit function
run_exit
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# run any external scripts
if ! cmd_exists "$APPNAME" && [ -f "$INSTDIR/build.sh" ]; then
  if builtin cd "$PLUGIN_DIR/source"; then
    BUILD_SCRIPT_SRC_DIR="$PLUGIN_DIR/source"
    BUILD_SRC_URL=""
    export BUILD_SCRIPT_SRC_DIR BUILD_SRC_URL
    eval "$INSTDIR/build.sh"
  fi
  cmd_exists $APPNAME || printf_red "$APPNAME is not installed: run $INSTDIR/build.sh"
fi
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# End application
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# lets exit with code
exit ${EXIT:-${exitCode:-0}}
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# ex: ts=2 sw=2 et filetype=sh
