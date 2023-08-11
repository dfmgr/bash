#!/usr/bin/env bash
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
##@Version           :  202304251026-git
# @@Author           :  Jason Hempstead
# @@Contact          :  git-admin@casjaysdev.pro
# @@License          :  LICENSE.md
# @@ReadME           :  bash-it --help
# @@Copyright        :  Copyright: (c) 2023 Jason Hempstead, Casjays Developments
# @@Created          :  Tuesday, Apr 25, 2023 19:50 EDT
# @@File             :  bash-it
# @@Description      :  Collection of community Bash commands and scripts
# @@Changelog        :  newScript
# @@TODO             :  Refactor code
# @@Other            :
# @@Resource         :
# @@Terminal App     :  no
# @@sudo/root        :  no
# @@Template         :  bash/system
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
export BASH_IT="${BASH_IT:-$HOME/.local/share/bash/plugins/bash-it}"
if [ -f "$BASH_IT/bash_it.sh" ]; then
  # Path to the bash it configuration

  # Lock and Load a custom theme file.
  # Leave empty to disable theming.
  # location /.bash_it/themes/
  export BASH_IT_THEME="${BASH_IT_THEME:-}"

  # Some themes can show whether `sudo` has a current token or not.
  # Set `$THEME_CHECK_SUDO` to `true` to check every prompt:
  export THEME_CHECK_SUDO="${THEME_CHECK_SUDO:-true}"

  # (Advanced): Change this to the name of your remote repo if you
  # cloned bash-it with a remote other than origin such as `bash-it`.
  export BASH_IT_REMOTE="${BASH_IT_REMOTE:-bash-it}"

  # (Advanced): Change this to the name of the main development branch if
  # you renamed it or if it was changed for some reason
  export BASH_IT_DEVELOPMENT_BRANCH="${BASH_IT_DEVELOPMENT_BRANCH:-main}"

  # Your place for hosting Git repos. I use this for private repos.
  export GIT_HOSTING="${GIT_HOSTING:-git@git.domain.com}"

  # Don"t check mail when opening terminal.
  export MAILCHECK="${MAILCHECK:-}"

  # Change this to your console based IRC client of choice.
  export IRC_CLIENT="${IRC_CLIENT:-irssi}"

  # Set this to the command you use for todo.txt-cli
  export TODO="${TODO:-todo}"

  # Set this to the location of your work or project folders
  BASH_IT_PROJECT_PATHS="${BASH_IT_PROJECT_PATHS:-$HOME/Projects}"

  # Set this to false to turn off version control status checking within the prompt for all themes
  export SCM_CHECK="${SCM_CHECK:-true}"
  # Set to actual location of gitstatus directory if installed
  #export SCM_GIT_GITSTATUS_DIR="$HOME/gitstatus"
  # per default gitstatus uses 2 times as many threads as CPU cores, you can change this here if you must
  #export GITSTATUS_NUM_THREADS="${GITSTATUS_NUM_THREADS:-8}"

  # Set Xterm/screen/Tmux title with only a short hostname.
  # Uncomment this (or set SHORT_HOSTNAME to something else),
  # Will otherwise fall back on $HOSTNAME.
  #export SHORT_HOSTNAME="${SHORT_HOSTNAME:-$(hostname -s)}"

  # Set Xterm/screen/Tmux title with only a short username.
  # Uncomment this (or set SHORT_USER to something else),
  # Will otherwise fall back on $USER.
  export SHORT_USER="${USER:0:12}"

  # If your theme use command duration, uncomment this to
  # enable display of last command duration.
  export BASH_IT_COMMAND_DURATION="${BASH_IT_COMMAND_DURATION:-true}"
  # You can choose the minimum time in seconds before
  # command duration is displayed.
  export COMMAND_DURATION_MIN_SECONDS="${COMMAND_DURATION_MIN_SECONDS:-1}"

  # Set Xterm/screen/Tmux title with shortened command and directory.
  # Uncomment this to set.
  #export SHORT_TERM_LINE=${SHORT_TERM_LINE:-false}

  # Set vcprompt executable path for scm advance info in prompt (demula theme)
  export VCPROMPT_EXECUTABLE="${VCPROMPT_EXECUTABLE:-$HOME/.local/bin/vcprompt}"

  # (Advanced): Uncomment this to make Bash-it reload itself automatically
  # after enabling or disabling aliases, plugins, and completions.
  export BASH_IT_AUTOMATIC_RELOAD_AFTER_CONFIG_CHANGE="${BASH_IT_AUTOMATIC_RELOAD_AFTER_CONFIG_CHANGE:-1}"

  # Uncomment this to make Bash-it create alias reload.
  export BASH_IT_RELOAD_LEGACY="${BASH_IT_RELOAD_LEGACY:-1}"

  # Load Bash It
  [ -n "$(type -t bash-it)" ] || source "$BASH_IT/bash_it.sh"
fi
