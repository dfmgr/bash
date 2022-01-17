#!/usr/bin/env bash
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
##@Version       : 202103251632-git
# @Author        : Jason Hempstead
# @Contact       : jason@casjaysdev.com
# @License       : LICENSE.md
# @ReadME        : 01-powerline.bash --help
# @Copyright     : Copyright: (c) 2021 Jason Hempstead, CasjaysDev
# @Created       : Thursday, Mar 25, 2021 18:00 EDT
# @File          : 01-powerline.bash
# @Description   : A highly informative prompt
# @TODO          : Refactor this to be more efficient
# @Other         :
# @Resource      : Borrowed and customized from https://github.com/riobard/bash-powerline
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
#Powerline check
if [ -z "$POWERLINE" ]; then
  #Debian/Ubuntu/Arch
  if [ -f "/usr/share/powerline/bindings/bash/powerline.sh" ]; then
    source "/usr/share/powerline/bindings/bash/powerline.sh"
  fi
  #Redhat/CentOS
  if [ -f "/usr/share/powerline/bash/powerline.sh" ]; then
    source "/usr/share/powerline/bash/powerline.sh"
  fi
  #MacOS
  if [ -f "/usr/local/lib/python3.7/site-packages/powerline/bindings/bash/powerline.sh" ]; then
    source "/usr/local/lib/python3.7/site-packages/powerline/bindings/bash/powerline.sh"
  fi
  [ -f "$(builtin type -P powerline-daemon 2>/dev/null)" ] && powerline-daemon -q
  export POWERLINE_BASH_CONTINUATION=1
  export POWERLINE_BASH_SELECT=1
fi
# noprompt completion
_noprompt_completion() {
  local cur prev words cword array shortopts longopts
  cur="${COMP_WORDS[COMP_CWORD]}"
  shortopts="-e -s -d"
  longopts="--enable --show --disable --help"
  array="date git go lua node path perl php python reminder ruby rust timer wakatime"
  _init_completion || return
  if [[ ${cur} == --* ]]; then
    COMPREPLY=($(compgen -W '${longopts}' -- ${cur}))
  elif [[ ${cur} == -* ]]; then
    COMPREPLY=($(compgen -W '${shortopts}' -- ${cur}))
  else
    case $prev in
    --help)
      COMPREPLY=($(compgen -W '' -- ${cur}))
      ;;
    *)
      COMPREPLY=($(compgen -W '${array}' -- "$cur"))
      ;;
    esac
  fi
}
# Disable prompt versions
noprompt() {
  local setopts=""
  local action="touch"
  local message="Disabled"
  local shortopts="e,s,d"
  local longopts="enable,show,disable,help"
  setopts=$(getopt -o "$shortopts" --long "$longopts" -a -n "noprompt" -- "$@" 2>/dev/null)
  eval set -- "${setopts[@]}" 2>/dev/null
  while :; do
    case "$1" in
    --enable | --show | -e | -s)
      shift 1
      echo -e "$@"
      action="rm -Rf"
      message="Enabled"
      ;;
    --disable | -d)
      shift 1
      ;;
    --help)
      printf_blue "Disable prompt messages"
      printf_blue "date git go lua node path perl php python reminder ruby rust timer wakatime"
      return
      ;;
    --)
      shift 1
      break
      ;;
    esac
  done
  while :; do
    case "$1" in
    date | time) $action "$HOME/.config/bash/noprompt/date" ;;
    git) $action "$HOME/.config/bash/noprompt/git" ;;
    go) $action "$HOME/.config/bash/noprompt/go" ;;
    lua) $action "$HOME/.config/bash/noprompt/lua" ;;
    node) $action "$HOME/.config/bash/noprompt/node" ;;
    path) $action "$HOME/.config/bash/noprompt/path" ;;
    perl) $action "$HOME/.config/bash/noprompt/perl" ;;
    php) $action "$HOME/.config/bash/noprompt/php" ;;
    python) $action "$HOME/.config/bash/noprompt/python" ;;
    reminder) $action "$HOME/.config/bash/noprompt/git_reminder" ;;
    ruby) $action "$HOME/.config/bash/noprompt/ruby" ;;
    rust) $action "$HOME/.config/bash/noprompt/rust" ;;
    timer) $action "$HOME/.config/bash/noprompt/timer" ;;
    wakatime) $action "$HOME/.config/bash/noprompt/wakatime" ;;
    esac
    printf_blue "$message $1"
    shift 1
    [[ $# -ne 0 ]] || break
  done
  exec bash -l
  return
}
# Initialize prompt
bashprompt() {
  printf_return() { return; }
  __find() {
    local dir="$PWD"
    local args=""
    [[ -d "$1" ]] && dir="$1" && shift 1
    [ $# -eq 0 ] && return || args="$*"
    find "$dir" -type l,f -maxdepth 1 ${args:-} -not -path "$dir/.git/*" 2>/dev/null | wc -l
  }

  # Unicode symbols
  PS_SYMBOL_DARWIN=' 🍎 ' 2>/dev/null
  PS_SYMBOL_LINUX=' 🐧 ' >/dev/null
  PS_SYMBOL_WIN=' 👽 ' >/dev/null
  PS_SYMBOL_OTHER=' ❓ ' 2>/dev/null
  GIT_BRANCH_SYMBOL='🎆 ' 2>/dev/null
  GIT_BRANCH_CHANGED_SYMBOL=' 🌲 ' 2>/dev/null
  GIT_NEED_PUSH_SYMBOL=' 🔼 ' 2>/dev/null
  GIT_NEED_PULL_SYMBOL=' 🔽 ' 2>/dev/null
  RUBY_SYMBOL=' 💎 ' 2>/dev/null
  NODE_SYMBOL=' 🔥 ' 2>/dev/null
  PYTHON_SYMBOL=' 🐍 ' 2>/dev/null
  PHP_SYMBOL=' ♻️ ' 2>/dev/null
  PERL_SYMBOL=' ☢️ ' 2>/dev/null
  LUA_SYMBOL=' ⚠️ ' 2>/dev/null
  GO_SYMBOL=' 👺 ' 2>/dev/null
  RUST_SYMBOL=' 🏗 ' 2>/dev/null

  # Foreground Colors
  __tput() { tput "$@" 2>/dev/null; }
  FG_BLACK="\[$(__tput setaf 0 2>/dev/null)\]"
  FG_GRAY1="\[$(__tput setaf 15 2>/dev/null)\]"
  FG_GRAY2="\[$(__tput setaf 7 2>/dev/null)\]"
  FG_GRAY3="\[$(__tput setaf 8 2>/dev/null)\]"
  FG_RED="\[$(__tput setaf 9 2>/dev/null)\]"
  FG_GREEN="\[$(__tput setaf 10 2>/dev/null)\]"
  FG_YELLOW="\[$(__tput setaf 11 2>/dev/null)\]"
  FG_BLUE="\[$(__tput setaf 12 2>/dev/null)\]"
  FG_MAGENTA="\[$(__tput setaf 13 2>/dev/null)\]"
  FG_CYAN="\[$(__tput setaf 14 2>/dev/null)\]"
  FG_DARK_RED="\[$(__tput setaf 1 2>/dev/null)\]"
  FG_DARK_GREEN="\[$(__tput setaf 2 2>/dev/null)\]"
  FG_MUSTARD="\[$(__tput setaf 3 2>/dev/null)\]"
  FG_NAVY="\[$(__tput setaf 4 2>/dev/null)\]"
  FG_PURPLE="\[$(__tput setaf 5 2>/dev/null)\]"
  FG_TURQUOISE="\[$(__tput setaf 6 2>/dev/null)\]"

  # Background Colors
  BG_BLACK="\[$(__tput setab 0 2>/dev/null)\]"
  BG_GRAY1="\[$(__tput setab 15 2>/dev/null)\]"
  BG_GRAY2="\[$(__tput setab 7 2>/dev/null)\]"
  BG_GRAY3="\[$(__tput setab 8 2>/dev/null)\]"
  BG_RED="\[$(__tput setab 9 2>/dev/null)\]"
  BG_GREEN="\[$(__tput setab 10 2>/dev/null)\]"
  BG_YELLOW="\[$(__tput setab 11 2>/dev/null)\]"
  BG_BLUE="\[$(__tput setab 12 2>/dev/null)\]"
  BG_MAGENTA="\[$(__tput setab 13 2>/dev/null)\]"
  BG_CYAN="\[$(__tput setab 14 2>/dev/null)\]"
  BG_DARK_RED="\[$(__tput setab 1 2>/dev/null)\]"
  BG_DARK_GREEN="\[$(__tput setab 2 2>/dev/null)\]"
  BG_MUSTARD="\[$(__tput setab 3 2>/dev/null)\]"
  BG_NAVY="\[$(__tput setab 4 2>/dev/null)\]"
  BG_PURPLE="\[$(__tput setab 5 2>/dev/null)\]"
  BG_TURQUOISE="\[$(__tput setab 6 2>/dev/null)\]"
  BG_DEEP_GREEN="\[$(__tput setab 22 2>/dev/null)\]"
  DIM="\[$(__tput dim 2>/dev/null)\]"
  REVERSE="\[$(__tput rev 2>/dev/null)\]"
  RESET="\[$(__tput sgr0 2>/dev/null)\]"
  BOLD="\[$(__tput bold 2>/dev/null)\]"
  ### what OS #######################################################
  case "$(uname)" in
  Darwin)
    PS_SYMBOL="$PS_SYMBOL_DARWIN"
    ;;
  Linux)
    PS_SYMBOL="$PS_SYMBOL_LINUX"
    ;;
  msys* | Win* | MINGW* | CYGWIN*)
    PS_SYMBOL="$PS_SYMBOL_WIN"
    ;;
  *)
    PS_SYMBOL="$PS_SYMBOL_OTHER"
    ;;
  esac
  ### Timer #######################################################
  if [ -f "$HOME/.config/bash/noprompt/timer" ]; then
    ___time_it() { return; }
    ___time_it_pre() { return; }
  else
    ___time_it_pre() {
      local st
      st=$(HISTTIMEFORMAT='%s ' history 1 | awk '{print $2}')
      if [[ -z "$STARTTIME" ]] || { [[ -n "$STARTTIME" ]] && [[ "$STARTTIME" -ne "$st" ]]; }; then
        TIMER_ENDTIME=${EPOCHSECONDS:-1}
        TIMER_STARTTIME=${st:-0}
      else
        TIMER_ENDTIME=0
        TIMER_STARTTIME=0
      fi
    }
    ___time_it() {
      ___time_it_pre
      [[ -n "$TIMER_ENDTIME" ]] || TIMER_ENDTIME=$EPOCHSECONDS
      [[ -n "$TIMER_STARTTIME" ]] || TIMER_STARTTIME=$EPOCHSECONDS
      if ((TIMER_ENDTIME - TIMER_STARTTIME > 1)); then
        ___time_show() { printf '%ds' "$((TIMER_ENDTIME - TIMER_STARTTIME))"; }
      else
        ___time_show() { printf 0; }
      fi
    }
  fi
  ### Rust #######################################################
  if [ -f "$HOME/.config/bash/noprompt/rust" ] || [ -z "$(command -v rustc 2>/dev/null)" ]; then
    __ifrust() { return; }
    __rust_info() { return; }
  else
    __ifrust() {
      local gitdir version
      gitdir="$(git rev-parse --show-toplevel 2>/dev/null | grep '^' || echo "${CDD_CWD_DIR:-$PWD}")"
      if [[ "$(__find "$gitdir" "-iname *.rs")" -ne 0 ]] || [[ "$(__find "$gitdir" "-iname *.rlib")" -ne 0 ]]; then
        if [ -f "$(command -v rustc 2>/dev/null)" ]; then
          __rust_version() { printf "%s" "Rust: $(rustc --version | tr ' ' '\n' | grep ^[0-9.] | head -n1)"; }
        else
          __rust_version() { return; }
        fi
        __rust_info() {
          version="$(__rust_version)"
          [ -z "${version}" ] && return
          printf "%s" "| ${version}$RUST_SYMBOL$RESET"
        }
      else
        __rust_info() { return; }
      fi
    }
  fi
  ### GO #######################################################
  if [ -f "$HOME/.config/bash/noprompt/go" ] || [ -z "$(command -v go 2>/dev/null)" ]; then
    __ifgo() { return; }
    __go_info() { return; }
  else
    __ifgo() {
      local gitdir version
      gitdir="$(git rev-parse --show-toplevel 2>/dev/null | grep '^' || echo "${CDD_CWD_DIR:-$PWD}")"
      if [[ "$(__find "$gitdir" "-iname *.go")" -ne 0 ]]; then
        if [ -f "$(command -v go 2>/dev/null)" ]; then
          __go_version() { printf "%s" "GO: $(go version | tr ' ' '\n' | grep 'go[0-9.]' | sed 's|go||g')"; }
        else
          __go_version() { return; }
        fi
        __go_info() {
          version="$(__go_version)"
          [ -z "${version}" ] && return
          printf "%s" "| ${version}$GO_SYMBOL$RESET"
        }
      else
        __go_info() { return; }
      fi
    }
  fi

  ### Ruby #######################################################
  if [ -f "$HOME/.config/bash/noprompt/ruby" ] || [ -z "$(command -v ruby 2>/dev/null)" ]; then
    __ifruby() { return; }
    __ruby_info() { return; }
  else
    __ifruby() {
      local gitdir version
      gitdir="$(git rev-parse --show-toplevel 2>/dev/null | grep '^' || echo "${CDD_CWD_DIR:-$PWD}")"
      if [[ "$(__find "$gitdir" "-iname *.gem")" -ne 0 ]] || [[ "$(__find "$gitdir" "-iname *.rb")" -ne 0 ]] || [[ "$(__find "$gitdir" "-name Gemfile")" -ne 0 ]]; then
        if [ -f "$(command -v rbenv 2>/dev/null)" ]; then
          __ruby_version() { printf "%s" "RBENV: $(rbenv version-name)"; }
        elif [ -f "$(command -v rvm 2>/dev/null)" ] && [ "$(rvm version | awk '{print $2}')" ]; then
          __ruby_version() { printf "%s" "RVM: $(rvm current)"; }
        elif [ -f "$(command -v ruby 2>/dev/null)" ]; then
          __ruby_version() { printf "%s" "Ruby: $(ruby --version | cut -d' ' -f2)"; }
        else
          __ruby_version() { return; }
        fi
        __ruby_info() {
          version="$(__ruby_version)"
          [ -z "${version}" ] && return
          printf "%s" "| ${version}$RUBY_SYMBOL$RESET"
        }
      else
        __ruby_info() { return; }
      fi
    }
  fi
  ### Node.js ####################################################
  if [ -f "$HOME/.config/bash/noprompt/node" ] || [ -z "$(command -v node 2>/dev/null)" ]; then
    __ifnode() { return; }
    __node_info() { return; }
  else
    __ifnode() {
      local gitdir version
      gitdir="$(git rev-parse --show-toplevel 2>/dev/null | grep '^' || echo "${CDD_CWD_DIR:-$PWD}")"
      if [[ "$(__find "$gitdir" "-iname *.js")" -ne 0 ]] || [[ "$(__find "$gitdir" "-name package.json")" -ne 0 ]] || [[ "$(__find "$gitdir" "-name yarn.lock")" -ne 0 ]]; then
        if [[ -f "$NVM_DIR/nvm.sh" ]] && [[ -n "$(command -v nvm_ls_current 2>/dev/null)" ]] &&
          [[ "$(nvm current)" != "system" ]]; then
          __node_version() { printf "%s" "$(node --version)"; }
          __node_info() {
            version="$(__node_version)"
            [ -z "${version}" ] && return
            printf "%s" "| NVM: ${version}$NODE_SYMBOL${RESET}"
          }
        elif [[ -f "$(command -v fnm)" ]]; then
          __node_version() { printf "%s" "$(node --version)"; }
          __node_info() {
            version="$(__node_version)"
            [ -z "${version}" ] && return
            printf "%s" "| FNM: ${version}$NODE_SYMBOL${RESET}"
          }
        elif [[ -f "$(command -v node)" ]]; then
          __node_version() { printf "%s" "$(node --version)"; }
          __node_info() {
            version="$(__node_version)"
            [ -z "${version}" ] && return
            printf "%s" "| Node: ${version}$NODE_SYMBOL${RESET}"
          }
        fi
      else
        __node_version() { return; }
        __node_info() { return; }
      fi
    }
  fi
  ### python ####################################################
  if [ -f "$HOME/.config/bash/noprompt/python" ] || [ -z "$(command -v python3 2>/dev/null)" ] || [ -z "$(command -v python2 2>/dev/null)" ]; then
    __ifpython() { return; }
    __python_info() { return; }
  else
    __ifpython() {
      local gitdir pythonBin PYTHON_VERSION
      gitdir="$(git rev-parse --show-toplevel 2>/dev/null | grep '^' || echo "${CDD_CWD_DIR:-$PWD}")"
      [[ -n "$VIRTUAL_ENV" ]] && [[ ! -f "$gitdir/.venv/bin/activate" ]] && deactivate && return
      [[ -z "$VIRTUAL_ENV" ]] && [[ -f "$gitdir/bin/activate" ]] && . "$gitdir/bin/activate"
      [[ -z "$VIRTUAL_ENV" ]] && [[ -f "$gitdir/venv/bin/activate" ]] && . "$gitdir/venv/bin/activate"
      [[ -z "$VIRTUAL_ENV" ]] && [[ -f "$gitdir/.venv/bin/activate" ]] && . "$gitdir/.venv/bin/activate"
      if [[ -n "$VIRTUAL_ENV" ]] || [[ $(__find "$gitdir" "-name *.py") -ne 0 ]] || [[ $(__find "$gitdir" "-name *.py -o -name requirements.txt") -ne 0 ]]; then
        __python_info() {
          pythonBin="$(command -v python3 || command -v python2 || command -v python)"
          PYTHON_VERSION="$($pythonBin --version | sed 's#Python ##g')"
          if [[ "$VIRTUAL_ENV" =~ venv ]]; then
            PYTHON_VIRTUALENV="$(basename "$(dirname "$VIRTUAL_ENV")")"
          else
            PYTHON_VIRTUALENV="$(basename "$VIRTUAL_ENV")"
          fi
          if [ -n "$PYTHON_VIRTUALENV" ]; then
            printf "%s" "| $PYTHON_VIRTUALENV: $PYTHON_VERSION$PYTHON_SYMBOL$RESET"
          else
            printf "%s" "| Python: $PYTHON_VERSION$PYTHON_SYMBOL$RESET"
          fi
        }
      else
        __python_info() { return; }
      fi
    }
  fi
  ### php ####################################################
  if [ -f "$HOME/.config/bash/noprompt/php" ] || [ -z "$(command -v php 2>/dev/null)" ]; then
    __ifphp() { return; }
    __php_info() { return; }
  else
    __ifphp() {
      local gitdir version
      gitdir="$(git rev-parse --show-toplevel 2>/dev/null | grep '^' || echo "${CDD_CWD_DIR:-$PWD}")"
      if [[ "$(__find "$gitdir" "-iname *.php*")" -ne 0 ]]; then
        __php_version() { printf "%s" "$(php --version | awk '{print $2}' | head -n 1)"; }
      else
        __php_version() { return; }
      fi
      __php_info() {
        version=$(__php_version)
        [ -z "$version" ] && return
        printf "%s" "| PHP: $version$PHP_SYMBOL$RESET"
      }
    }
  fi
  ### perl ####################################################
  if [ -f "$HOME/.config/bash/noprompt/perl" ] || [ -z "$(command -v perl 2>/dev/null)" ]; then
    __ifperl() { return; }
    __perl_info() { return; }
  else
    __ifperl() {
      local gitdir version
      gitdir="$(git rev-parse --show-toplevel 2>/dev/null | grep '^' || echo "${CDD_CWD_DIR:-$PWD}")"
      if [[ "$(__find "$gitdir" "-iname *.pl")" -ne 0 ]] || [[ "$(__find "$gitdir" "-iname *.cgi")" -ne 0 ]]; then
        __perl_version() { printf "%s" "$(perl --version | tr ' ' '\n' | grep '.(*)' | sed 's#(##g;s#)##g' | head -n1)"; }
      else
        __perl_version() { return; }
      fi
      __perl_info() {
        version=$(__perl_version)
        [ -z "$version" ] && return
        printf "%s" "| Perl: $version$PERL_SYMBOL$RESET"
      }
    }
  fi
  ### lua ####################################################
  if [ -f "$HOME/.config/bash/noprompt/lua" ] || [ -z "$(command -v lua 2>/dev/null)" ]; then
    __iflua() { return; }
    __lua_info() { return; }
  else
    __iflua() {
      local gitdir version
      gitdir="$(git rev-parse --show-toplevel 2>/dev/null | grep '^' || echo "${CDD_CWD_DIR:-$PWD}")"
      if [[ "$(__find "$gitdir" "-iname *.lua")" -ne 0 ]]; then
        luaversion="$(lua -v 2>&1)"
        __lua_version() { printf "%s" "$(echo "$luaversion" | head -n1 | awk '{print $2}')"; }
      else
        __lua_version() { return; }
      fi
      __lua_info() {
        version="$(__lua_version)"
        [ -z "$version" ] && return
        printf "%s" "| Lua: $version$LUA_SYMBOL$RESET"
      }
    }
  fi
  ### Git ########################################################
  if [ -f "$HOME/.config/bash/noprompt/git" ] || [ -z "$(command -v git 2>/dev/null)" ]; then
    __ifgit() { return; }
    __git_info() { return; }
  else
    __ifgit() {
      local gitdir marks git_eng branch stat aheadN behindN
      if [ "$(git rev-parse --is-inside-work-tree 2>/dev/null)" == "true" ]; then
        __git_version() { printf "%s" "| Git: $(git --version | awk '{print $3}' | head -n 1)"; }
        __git_status() {
          git_eng="env LANG=C git" # force git output in English to make our work easier
          branch="$($git_eng symbolic-ref --short HEAD 2>/dev/null || $git_eng describe --tags --always 2>/dev/null)"
          [ -n "$branch" ] || return # git branch not found
          [ -n "$($git_eng status --porcelain)" ] && marks+="$GIT_BRANCH_CHANGED_SYMBOL"
          stat="$($git_eng status --porcelain --branch | grep '^##' | grep -o '\[.\+\]$')"
          aheadN="$(echo -n "$stat" | grep -o 'ahead [[:digit:]]\+' | grep -o '[[:digit:]]\+')"
          behindN="$(echo -n "$stat" | grep -o 'behind [[:digit:]]\+' | grep -o '[[:digit:]]\+')"
          [ -n "$aheadN" ] && marks+="$GIT_NEED_PUSH_SYMBOL$aheadN"
          [ -n "$behindN" ] && marks+="$GIT_NEED_PULL_SYMBOL$behindN"
          printf "%s" " [$branch]$marks"
        }
        __git_info() {
          __git_version && __git_status && printf "%s" "$GIT_BRANCH_SYMBOL"
        }
      else
        __git_version() { return; }
        __git_info() { return; }
      fi
    }
  fi
  ### Git reminder ###############################################
  if [ -z "$(command -v __git_prompt_message_warn 2>/dev/null)" ] || [ -z "$(command -v git 2>/dev/null)" ]; then
    __git_prompt_message_warn() { return; }
  fi
  if [ -f "$HOME/.config/bash/noprompt/git_reminder" ]; then
    __git_prompt_message_warn() { return; }
  else
    __git_prompt_message_warn() {
      local gitdir grepgitignore
      if [[ "$(git rev-parse --is-inside-work-tree 2>/dev/null)" == "true" ]]; then
        gitdir="$(git rev-parse --show-toplevel 2>/dev/null | grep '^' || echo "${CDD_CWD_DIR:-$PWD}")"
        grepgitignore="$(grep -q ignoredirmessage "$gitdir/.gitignore" 2>/dev/null && echo 0 || echo 1)"
        if [ "$grepgitignore" -ne 0 ]; then
          printf "%s" "|${BG_BLACK}${FG_GREEN} Dont forget to do a git pull $RESET"
        fi
      fi
    }
  fi
  ### WakaTime ####################################################
  if [ -f "$HOME/.config/bash/noprompt/wakatime" ] || [ -z "$(command -v wakatime 2>/dev/null)" ]; then
    ___wakatime_prompt() { return; }
    ___wakatime_show() { return; }
  elif grep -qi api_key "$HOME/.wakatime.cfg"; then
    ___wakatime_show() {
      local devtime
      devtime="$(wakatime --today 2>/dev/null || return)"
      if [ -n "$devtime" ]; then
        WAKA_PROMPT_MESSAGE="$(printf '[Dev Time: %s]' "${setwakatime:-$devtime}")"
        WAKA_PROMPT_COUNT="${#WAKA_PROMPT_MESSAGE}"
      else
        return
      fi
    }
    ___wakatime_prompt() {
      local version entity project
      version="1.0.0"
      entity="$(echo "$(fc -ln -0)" | cut -d ' ' -f1 || return)"
      if [ -z "$entity" ]; then
        return 0
      else
        if git rev-parse --is-inside-work-tree 2>/dev/null | grep -iq 'true'; then
          project="$(basename "$(git rev-parse --show-toplevel)")"
        else
          project="Terminal"
        fi
        (wakatime --write --plugin "bash-wakatime/$version" --entity-type app --project $project --entity $entity >/dev/null 2>&1 &)
      fi
    }
  else
    ___wakatime_prompt() { return; }
  fi
  #
  ### Add time ########################################
  if [ -f "$HOME/.config/bash/noprompt/date" ]; then
    ___date_show() { return; }
  else
    ___date_show() {
      DATETIME_PROMPT_MESSAGE="$(printf '[Time: %s]' "$(date '+%H:%M')")"
      DATETIME_PROMPT_COUNT="${#DATETIME_PROMPT_MESSAGE}"
    }
  fi
  ### Add bash/screen/tmux version ########################################
  __prompt_version() {
    local bash tmux screen byobu
    bash="Bash: ${BASH_VERSION%.*}"
    tmux="$(pidof tmux &>/dev/null && echo -n "$(tmux -V | tr ' ' '\n' | grep [0-9.] 2>/dev/null | head -n1 | grep '^')")"
    screen="$(pidof screen &>/dev/null && echo -n "$(screen --version 2>/dev/null | tr ' ' '\n' | grep -wE '[0-9]' | head -n1 | grep '^')")"
    byobu="$(env | grep -q BYOBU_TERM &>/dev/null && echo -n "$(byobu --version | grep byobu | tr ' ' '\n' | grep '[0..9]')")"
    if [ -n "$byobu" ]; then
      printf 'byobu:%s' "$byobu"
    elif [ -n "$screen" ]; then
      printf 'screen:%s' "$screen"
    elif [ -n "$tmux" ]; then
      printf 'tmux:%s' "$tmux"
    elif [ -n "$bash" ]; then
      printf '%s' "$bash"
    else
      printf '%s' "$TERM"
    fi
  }
  ### Add bin to path ########################################
  ___add_bin_path() {
    if [[ -d "$PWD/bin" ]] && [[ -z "$RESET_PATH" ]]; then
      export RESET_PATH="$PATH"
      export PATH="$PWD/bin:$RESET_PATH"
    else
      [[ -z "$RESET_PATH" ]] || export PATH="$RESET_PATH"
      unset RESET_PATH
    fi
  }
  ### Add PROMPT  Message ########################################
  __ps1_additional() {
    if [ -n "$PS1_ADD" ]; then
      printf "%s" "${BG_BLACK:-$ADD_BGCOLOR}${FG_GREEN:-$ADD_FG}|${PS1_ADD:-}${RESET:-$ADD_RESET}"
    fi
  }
  __additional_msg() {
    __git_prompt_message_warn
    __ps1_additional
  }
  ### PROMPT #####################################################
  __title_info() {
    echo -ne "${USER}@${HOSTNAME%%.*}:${PWD/$HOME/~}"
  }
  # Add all additional pre commands here command
  __pre_prompt_command() {
    local EXIT=$? # Keep this here as it is needed for prompt
    ___time_it
    ___wakatime_prompt
    ___add_bin_path
    return $EXIT
  }
  # Add all additional post commands here command
  __post_prompt_command() {
    history -a &>/dev/null && history -r &>/dev/null
  }
  case $TERM in
  *-256color)
    title() { echo -ne "\033]0;$(__title_info)\007"; }
    ;;
  xterm* | rxvt* | Eterm | aterm | kterm | gnome* | konsole | xfce4-terminal* | putty*)
    title() { echo -ne "\033]0;$(__title_info)\007"; }
    ;;
  screen*)
    title() { echo -ne "\033]0;$(__title_info)\007"; }
    ;;
  *)
    title() { echo -ne "\033]0;$(__title_info)\007"; }
    ;;
  esac
  ps1() {
    local EXIT=$?
    if [ $EXIT -eq 0 ]; then
      local BG_EXIT="$BG_DARK_GREEN"
      local PS_SYMBOL="${PS_SYMBOL:- 😇 }"
    else
      local BG_EXIT="$BG_RED"
      local PS_SYMBOL=" 😔 "
    fi
    [[ -n "$NEW_PS_SYMBOL" ]] && PS_SYMBOL="$NEW_PS_SYMBOL" && unset NEW_PS_SYMBOL
    [[ -n "$NEW_BG_EXIT" ]] && BG_EXIT="$NEW_BG_EXIT" && unset NEW_BG_EXIT

    ___date_show
    ___wakatime_show
    PS_LINE="$(printf -- '%.0s' {4..2000})"
    PS_FILL="${PS_LINE:0:$((COLUMNS - 1))}"
    PS_TIME="\[\033[\$((COLUMNS-${WAKA_PROMPT_COUNT:-0}-${DATETIME_PROMPT_COUNT:-0}-1))G\]${RESET}${BG_PURPLE}${FG_BLACK}${WAKA_PROMPT_MESSAGE} ${DATETIME_PROMPT_MESSAGE}$RESET"
    PS1="\${PS_FILL}\[\033[0G\]$RESET"
    PS1+="$BG_BLUE$FG_BLACK$(__prompt_version)$RESET"
    PS1+="$BG_PURPLE$FG_GRAY1$(__ifphp && __php_info)$RESET"
    PS1+="$BG_DARK_RED$FG_GRAY1$(__ifruby && __ruby_info)$RESET"
    PS1+="$BG_DEEP_GREEN$FG_GRAY1$(__ifnode && __node_info)$RESET"
    PS1+="$BG_RED$FG_BLACK$(__ifpython && __python_info)$RESET"
    PS1+="$BG_PURPLE$FG_BLACK$(__ifperl && __perl_info)$RESET"
    PS1+="$BG_MAGENTA$FG_BLACK$(__iflua && __lua_info)$RESET"
    PS1+="$BG_RED$FG_BLACK$(__ifrust && __rust_info)$RESET"
    PS1+="$BG_YELLOW$FG_BLACK$(__ifgo && __go_info)$RESET"
    PS1+="$BG_DARK_RED$FG_BLACK$(__ifgit && __git_info)$RESET"
    PS1+="$BG_PURPLE$FG_BLACK${PS_TIME}$RESET\n"
    PS1+="$BG_GRAY2$FG_BLACK\u@\H: $BG_DARK_GREEN\w:$RESET$(__additional_msg)\n"
    PS1+="$BG_EXIT${FG_BLACK}Time:[$(___time_show)] Jobs:[\j]$BG_GRAY1${PS1_ADD_PROMPT:-}$PS_SYMBOL:$RESET "
  }
  PROMPT_COMMAND="__pre_prompt_command;ps1;title;__post_prompt_command; "
  # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  # ------------------------------------------------------------------
  # | PS2 - Continuation interactive prompt                          |
  # ------------------------------------------------------------------
  PS2="⚡ "
  export PS2
  # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  # ------------------------------------------------------------------
  # | PS4 - debug interactive prompt                          |
  # ------------------------------------------------------------------
  PS4="$(
    tput cr 2>/dev/null
    tput cuf 6 2>/dev/null
    printf "${GREEN}+%s ($LINENO) +" " $RESET"
  )"
  export PS4
}
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
complete -F _noprompt_completion -o default noprompt
bashprompt 2>/dev/null
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# end
