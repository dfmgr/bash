#!/usr/bin/env bash
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
##@Version       : 202103251632-git
# @Author        : Jason Hempstead
# @Contact       : jason@casjaysdev.pro
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
# Install fonts
if [ ! -f "$HOME/.local/share/fonts/PowerlineSymbols.otf" ] || [ ! -f "$HOME/.local/share/fonts/10-powerline-symbols.conf" ]; then
  mkdir -p "$HOME/.local/share/fonts" &>/dev/null
  curl -q -LSsf --create-dirs "https://github.com/powerline/powerline/raw/develop/font/PowerlineSymbols.otf" -o "$HOME/.local/share/fonts/PowerlineSymbols.otf" 2>/dev/null &&
    curl -q -LSsf --create-dirs "https://github.com/powerline/powerline/raw/develop/font/10-powerline-symbols.conf" -o "$HOME/.local/share/fonts/10-powerline-symbols.conf" 2>/dev/null &&
    fc-cache -vf "$HOME/.local/share/fonts" &>/dev/null
fi
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# Powerline check
if [ -z "$(builtin command -v powerline-daemon 2>/dev/null)" ]; then
  # Debian/Ubuntu/Arch
  if [ -f "/usr/share/powerline/bindings/bash/powerline.sh" ]; then
    . "/usr/share/powerline/bindings/bash/powerline.sh"
  # Redhat/CentOS
  elif [ -f "/usr/share/powerline/bash/powerline.sh" ]; then
    . "/usr/share/powerline/bash/powerline.sh"
    # Try to find powerline.sh
    powerline_sh="$(find /usr/*/powerline /usr/lib/python*/dist-packages /usr/local/lib/python*/dist-packages -iname 'powerline.sh' 2>/dev/null | grep bindings/bash | head -n1)"
  elif [ -f "$powerline_sh" ]; then
    . "$powerline_sh"
    unset powerline_sh
  fi
  # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  # Start
  if [ -f "$(builtin command -v powerline-daemon 2>/dev/null)" ]; then
    export POWERLINE_BASH_CONTINUATION=1
    export POWERLINE_BASH_SELECT=1
    powerline-daemon -q
  fi
fi
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# Disable prompt versions
noprompt() {
  local setopts=""
  local action="touch"
  local message="Disabled"
  local shortopts="e,s,d"
  local longopts="enable,show,disable,help,disable-all,enable-all"
  local array="date git go lua node path perl php python reminder ruby rust timer wakatime"
  setopts=$(getopt -o "$shortopts" --long "$longopts" -a -n "noprompt" -- "$@" 2>/dev/null)
  eval set -- "${setopts[@]}" 2>/dev/null
  while :; do
    case "$1" in
    --disable | -d)
      shift 1
      ;;
    --enable | -e | -s)
      shift 1
      action="rm -Rf"
      message="Enabled"
      ;;
    --help)
      shift 1
      printf_blue "Disable prompt messages"
      printf_blue "${array}"
      return
      ;;
    --disable-all)
      shift 1
      for f in ${array}; do
        printf_blue "Disabled ${f}"
        touch "$HOME/.config/bash/noprompt/$f"
      done
      if [ -f "${BASH_SOURCE[0]}" ]; then
        printf "${GREEN}Updating prompt from: %s\n" "${BASH_SOURCE[0]}"
        exec bash -s "${BASH_SOURCE[0]}"
      fi
      return
      ;;
    --enable-all)
      shift 1
      for f in ${array}; do
        printf_blue "Enabled ${f}"
        [ -f "$HOME/.config/bash/noprompt/$f" ] && rm -Rf "$HOME/.config/bash/noprompt/$f"
      done
      if [ -f "${BASH_SOURCE[0]}" ]; then
        printf "${GREEN}Updating prompt from: %s\n" "${BASH_SOURCE[0]}"
        exec bash -s "${BASH_SOURCE[0]}"
      fi
      return
      ;;
    --show)
      shift 1
      for f in ${array}; do
        [ -f "$HOME/.config/bash/noprompt/$f" ] && printf_yellow "$f is disabled" || printf_green "$f is enabled"
      done
      ;;
    --)
      shift 1
      break
      ;;
    esac
  done
  [ $# -eq 0 ] && return
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
    [ $# -ne 0 ] || break
  done
  if [ -f "${BASH_SOURCE[0]}" ]; then
    printf "${GREEN}Updating prompt from: %s\n" "${BASH_SOURCE[0]}"
    exec bash -s "${BASH_SOURCE[0]}"
  fi
  return
}
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# Initialize prompt
bashprompt() {
  printf_return() { return; }
  ___bash_find() {
    local findExitCode="1" dir="" count="" args=("")
    [ -d "$1" ] && dir="$1" && shift 1 || dir="$PWD"
    [ $# -eq 0 ] && return 1 || args=("$@")
    for arg in "${args[@]}"; do
      count="$(find -L "$dir" -maxdepth 1 -type f -iname "$arg" -not -path "$dir/.git/*" 2>/dev/null | wc -l | grep '^' || echo '')"
      [ "$count" -ne 0 ] && return 0
    done
    return 1
  }
  # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  # Unicode symbols
  PS_SYMBOL_DARWIN=' 🍎 '
  PS_SYMBOL_LINUX=' 🐧 '
  PS_SYMBOL_WIN=' 👽 '
  PS_SYMBOL_OTHER=' ❓ '
  GIT_BRANCH_SYMBOL='🎆 '
  GIT_BRANCH_CHANGED_SYMBOL=' 🌲 '
  GIT_NEED_PUSH_SYMBOL=' 🔼 '
  GIT_NEED_PULL_SYMBOL=' 🔽 '
  RUBY_SYMBOL=' 💎 '
  NODE_SYMBOL=' 🔥 '
  PYTHON_SYMBOL=' 🐍 '
  PHP_SYMBOL=' ♻️ '
  PERL_SYMBOL=' ☢️ '
  LUA_SYMBOL=' ⚠️ '
  GO_SYMBOL=' 👺 '
  RUST_SYMBOL=' 🏗 '
  # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
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
  # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
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
  # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  # Get OS
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
  # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  # Timer
  ___time_it_pre() {
    local st es
    local es=${EPOCHSECONDS:-$(date +%s)}
    [ -f "$HOME/.config/bash/noprompt/timer" ] && return 1
    st=$(HISTTIMEFORMAT='%s ' history 1 | awk '{print $2}' | grep '^' || echo ${es:-$(date +%s)})
    if [ -z "$STARTTIME" ] || { [ -n "$STARTTIME" ] && [ "$STARTTIME" -ne "$st" ]; }; then
      TIMER_ENDTIME=${EPOCHSECONDS:-1}
      TIMER_STARTTIME=${st:-0}
    else
      TIMER_ENDTIME=0
      TIMER_STARTTIME=0
    fi
  }
  ___time_it() {
    [ -f "$HOME/.config/bash/noprompt/timer" ] && ___time_show() { return; } && return 1
    ___time_it_pre
    [ -n "$TIMER_ENDTIME" ] || TIMER_ENDTIME=$EPOCHSECONDS
    [ -n "$TIMER_STARTTIME" ] || TIMER_STARTTIME=$EPOCHSECONDS
    if ((TIMER_ENDTIME - TIMER_STARTTIME > 0)); then
      ___time_show() { printf 'Time:[%ds]|' $((TIMER_ENDTIME - TIMER_STARTTIME)); }
    else
      ___time_show() { printf 0; }
    fi
  }
  # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  # Rust
  __ifrust() {
    local version
    rustBin="$(builtin command -v rustc || false)"
    if [ -f "$HOME/.config/bash/noprompt/rust" ] || [ -z "$rustBin" ]; then
      return 1
    fi
    if ___bash_find "$BASHRC_GITDIR" '*.rs'; then
      __rust_version() { printf "| Rust: %s" "$($rustBin --version | tr ' ' '\n' | grep ^[0-9.] | head -n1)"; }
      __rust_info() {
        version="$(__rust_version)"
        [ -z "${version}" ] && return
        printf "%s" "${version}$RUST_SYMBOL$RESET"
      }
    else
      __rust_info() { return; }
    fi
  }
  # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  # GO
  __ifgo() {
    local version
    goBin="$(builtin command -v go || false)"
    if [ -f "$HOME/.config/bash/noprompt/go" ] || [ -z "$goBin" ]; then
      return 1
    fi
    if ___bash_find "$BASHRC_GITDIR" '*.go'; then
      __go_version() { printf "%s" "GO: $($goBin version | tr ' ' '\n' | grep 'go[0-9.]' | sed 's|go||g')"; }
      __go_info() {
        version="$(__go_version)"
        [ -z "${version}" ] && return
        printf "%s" "| ${version}$GO_SYMBOL$RESET"
      }
    else
      __go_info() { return; }
    fi
  }
  # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  # Ruby
  __ifruby() {
    local version
    rubyBin="$(builtin command -v ruby || false)"
    if [ -f "$HOME/.config/bash/noprompt/ruby" ] || [ -z "$rubyBin" ]; then
      return 1
    fi
    if ___bash_find "$BASHRC_GITDIR" '*.gem' '*.rb' 'Gemfile'; then
      if [ -f "$(builtin command -v rbenv 2>/dev/null)" ]; then
        __ruby_version() { printf "%s" "RBENV: $(rbenv version-name)"; }
      elif [ -f "$(builtin command -v rvm 2>/dev/null)" ] && [ "$(rvm version | awk '{print $2}')" ]; then
        __ruby_version() { printf "%s" "RVM: $(rvm current)"; }
      elif [ -f "$(builtin command -v ruby 2>/dev/null)" ]; then
        __ruby_version() { printf "%s" "Ruby: $($rubyBin --version | cut -d' ' -f2)"; }
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
  # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  # Node.js
  __ifnode() {
    local version
    nodeBin="$(builtin command -v node || false)"
    if [ -f "$HOME/.config/bash/noprompt/node" ] || [ -z "$nodeBin" ]; then
      return 1
    fi
    if ___bash_find "$BASHRC_GITDIR" '*.js' 'package.json' 'yarn.lock'; then
      __node_version() { printf "%s" "$($nodeBin --version)"; }
      if [ -f "$NVM_DIR/nvm.sh" ] && [ -n "$(builtin command -v nvm_ls_current 2>/dev/null)" ] && [ "$(nvm current)" != "system" ]; then
        __node_info() { printf "%s" "| NVM: $(__node_version)$NODE_SYMBOL${RESET}"; }
      elif [ -f "$(builtin command -v fnm)" ]; then
        __node_info() { printf "%s" "| FNM: $(__node_version)$NODE_SYMBOL${RESET}"; }
      else
        __node_info() { printf "%s" "| Node: $(__node_version)$NODE_SYMBOL${RESET}"; }
      fi
    else
      __node_version() { return; }
      __node_info() { return; }
    fi
  }
  # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  # python
  ___if_venv() {
    local venv_dir="${1:-${BASHRC_GITDIR:-$PWD}}"
    if [ -n "$VIRTUAL_ENV_PROMPT" ] && [ ! -f "$PYTHON_SOURCE_FILE" ]; then
      type deactivate &>/dev/null && deactivate
      unset PYTHON_VIRTUALENV PYTHON_SOURCE_FILE
      return
    fi
    if [ -z "$VIRTUAL_ENV" ] && [ -f "$venv_dir/bin/activate" ]; then
      PYTHON_SOURCE_FILE="$(realpath "$venv_dir/bin/activate")"
      PYTHON_VIRTUALENV="$(basename "$(realpath "$venv_dir")")"
    elif [ -z "$VIRTUAL_ENV" ] && [ -f "$venv_dir/venv/bin/activate" ]; then
      PYTHON_SOURCE_FILE="$(realpath "$venv_dir/venv/bin/activate")"
      PYTHON_VIRTUALENV="$(basename "$(realpath "$venv_dir")")"
    elif [ -z "$VIRTUAL_ENV" ] && [ -f "$venv_dir/.venv/bin/activate" ]; then
      PYTHON_SOURCE_FILE="$(realpath "$venv_dir/.venv/bin/activate")"
      PYTHON_VIRTUALENV="$(basename "$(realpath "$venv_dir")")"
    elif [ -z "$VIRTUAL_ENV" ] && [ -f "$SETV_VIRTUAL_DIR_PATH/bin/activate" ]; then
      PYTHON_SOURCE_FILE="$(realpath "$SETV_VIRTUAL_DIR_PATH/bin/activate")"
      PYTHON_VIRTUALENV="$(basename "$(realpath "$SETV_VIRTUAL_DIR_PATH")")"
    fi
    [ -f "$PYTHON_SOURCE_FILE" ] && . "$PYTHON_SOURCE_FILE" && export PYTHON_VIRTUALENV PYTHON_SOURCE_FILE || true
  }
  # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  __ifpython() {
    local PYTHON_VERSION
    pythonBin="$(builtin command -v python3 || builtin command -v python2 || builtin command -v python || false)"
    if [ -f "$HOME/.config/bash/noprompt/python" ] || [ -z "$pythonBin" ]; then
      return 1
    fi
    [ -n "$PYTHON_SOURCE_FILE" ] && [ -f "$PYTHON_SOURCE_FILE" ] || ___if_venv "$BASHRC_GITDIR"
    if ___bash_find "$BASHRC_GITDIR" '*.py' 'requirements.txt' && [ -n "$pythonBin" ]; then
      [ -n "$VIRTUAL_ENV_PROMPT" ] || ___if_venv "$BASHRC_GITDIR"
      __python_info() {
        PYTHON_VERSION="$($PYTHONBIN --version | sed 's#Python ##g')"
        if [ -n "$PYTHON_VIRTUALENV" ]; then
          printf "%s" "| $PYTHON_VIRTUALENV: $PYTHON_VERSION$PYTHON_SYMBOL$RESET"
        else
          printf "%s" "| Python: $PYTHON_VERSION$PYTHON_SYMBOL$RESET"
        fi
      }
    else
      __python_info() { return; }
    fi
    export PYTHONBIN="$pythonBin"
  }
  # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  # php
  __ifphp() {
    local version
    phpBin="$(builtin command -v php8 || builtin command -v php7 || builtin command -v php5 || builtin command -v php || false)"
    if [ -f "$HOME/.config/bash/noprompt/php" ] || [ -z "$phpBin" ]; then
      return 1
    fi
    if ___bash_find "$BASHRC_GITDIR" '*.php*' 'composer.json'; then
      __php_version() { printf "%s" "$($phpBin --version | awk '{print $2}' | head -n 1 | grep '^' || echo 'unknown')"; }
    else
      __php_version() { return; }
    fi
    __php_info() {
      version=$(__php_version)
      [ -z "$version" ] && return
      printf "%s" "| PHP: ${version}${PHP_SYMBOL}${RESET}"
    }
  }
  # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  # perl
  __ifperl() {
    local version
    perlBin="$(builtin command -v perl || false)"
    if [ -f "$HOME/.config/bash/noprompt/perl" ] || [ -z "$perlBin" ]; then
      return 1
    fi
    if ___bash_find "$BASHRC_GITDIR" '*.pl' '*.cgi'; then
      __perl_version() { printf "%s" "$($perlBin --version | tr ' ' '\n' | grep '.(*)' | sed 's#(##g;s#)##g' | head -n1)"; }
    else
      __perl_version() { return; }
    fi
    __perl_info() {
      version=$(__perl_version)
      [ -z "$version" ] && return
      printf "%s" "| Perl: $version$PERL_SYMBOL$RESET"
    }
  }
  # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  # lua
  __iflua() {
    local version
    luaBin="$(builtin command -v lua || false)"
    if [ -f "$HOME/.config/bash/noprompt/lua" ] || [ -z "$luaBin" ]; then
      return 1
    fi
    if ___bash_find "$BASHRC_GITDIR" '*.lua'; then
      __lua_version() { printf "%s" "$($luaBin -v 2>&1 | head -n1 | awk '{print $2}')"; }
    else
      __lua_version() { return; }
    fi
    __lua_info() {
      version="$(__lua_version)"
      [ -z "$version" ] && return
      printf "%s" "| Lua: $version$LUA_SYMBOL$RESET"
    }
  }
  # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  # Git
  __ifgit() {
    local marks git_eng branch stat aheadN behindN
    gitBin="$(builtin command -v git || false)"
    if [ -f "$HOME/.config/bash/noprompt/git" ] || [ -z "$gitBin" ]; then
      return 1
    fi
    if [ "$(git rev-parse --is-inside-work-tree 2>/dev/null)" == "true" ]; then
      __git_version() { printf "%s" "| Git: $($gitBin --version 2>/dev/null | awk '{print $3}' | head -n 1)"; }
      __git_status() {
        git_eng="env LANG=C git"
        branch="$($git_eng symbolic-ref --short HEAD 2>/dev/null || $git_eng describe --tags --always 2>/dev/null)"
        [ -n "$branch" ] || return # git branch not found
        [ -n "$($git_eng status --porcelain 2>/dev/null)" ] && marks+="$GIT_BRANCH_CHANGED_SYMBOL"
        stat="$($git_eng status --porcelain --branch | grep '^##' | grep -o '\[.\+\]$' 2>/dev/null)"
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
  # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  # Git reminder
  __git_prompt_message_warn() {
    local grepgitignore
    if [ -f "$HOME/.config/bash/noprompt/git_reminder" ] || [ -z "$(builtin command -v __git_prompt_message_warn 2>/dev/null)" ] || [ -z "$(builtin command -v git 2>/dev/null)" ]; then
      return 1
    fi
    if [ "$(git rev-parse --is-inside-work-tree 2>/dev/null)" == "true" ]; then
      grepgitignore="$(grep -q ignoredirmessage "$BASHRC_GITDIR/.gitignore" 2>/dev/null && echo 0 || echo 1)"
      if [ "$grepgitignore" -ne 0 ]; then
        printf "%s" "|${BG_BLACK}${FG_GREEN} Dont forget to do a git pull $RESET"
      fi
    fi
  }
  # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  # WakaTime
  __ifwakatime() {
    if [ -f "$HOME/.config/bash/noprompt/wakatime" ] || [ -z "$(builtin command -v wakatime 2>/dev/null)" ]; then
      ___wakatime_show() { return 1; }
      ___wakatime_prompt() { return 1; }
      return 1
    fi
  }
  ___wakatime_show() {
    local devtime
    devtime="$(wakatime --today 2>/dev/null || return)"
    if [ -n "$devtime" ]; then
      WAKA_PROMPT="$(printf '[Dev Time: %s]' "${setwakatime:-$devtime}")"
      WAKA_PROMPT_COUNT="${#WAKA_PROMPT}"
      WAKA_PROMPT_MESSAGE="${RESET}${BG_PURPLE}${FG_BLACK}${WAKA_PROMPT}${RESET} "
    else
      return
    fi
  }
  ___wakatime_prompt() {
    local version entity project
    version="1.0.0"
    entity="$(echo "$(fc -ln -0)" | cut -d ' ' -f1 || false)"
    if [ -z "$entity" ]; then
      return 0
    else
      if git rev-parse --is-inside-work-tree 2>/dev/null | grep -iq 'true'; then
        project="$(basename "$(git rev-parse --show-toplevel 2>/dev/null)")"
      else
        project="Terminal"
      fi
      (wakatime --write --plugin "bash-wakatime/$version" --entity-type app --project $project --entity $entity &>/dev/null &)
    fi
  }
  # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  # Add time
  __ifdate() {
    if [ -f "$HOME/.config/bash/noprompt/date" ]; then
      return 1
    fi
    ___date_show() {
      DATETIME_PROMPT="$(printf '[Time: %s]' "$(date '+%H:%M')")"
      DATETIME_PROMPT_COUNT="${#DATETIME_PROMPT}"
      DATETIME_PROMPT_MESSAGE=" ${RESET}${BG_PURPLE}${FG_BLACK}${DATETIME_PROMPT}${RESET}"
    }
  }
  # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  # Add bash/screen/tmux version
  __prompt_version() {
    local bash tmux screen byobu shell
    bash="${BASH_VERSION%.*}"
    tmux="$(pidof tmux &>/dev/null && echo -n "$(tmux -V 2>/dev/null | tr ' ' '\n' | grep '[0-9].' | head -n1 | sed 's/[^.0-9]*//g' | grep -s '^')")"
    screen="$(pidof screen &>/dev/null && echo -n "$(screen --version 2>/dev/null | tr ' ' '\n' | grep -wE '[0-9]' | sed 's/[^.0-9]*//g' | head -n1 | grep '^')")"
    byobu="$(env | grep -q BYOBU_TERM &>/dev/null && echo -n "$(byobu --version 2>/dev/null | grep byobu | tr ' ' '\n' | sed 's/[^.0-9]*//g' | grep '[0..9]')")"
    if [ -n "$byobu" ]; then
      shell="byobu: "
      version="$byobu"
    elif [ -n "$screen" ] && [ -n "$SCREENEXCHANGE" ]; then
      shell="screen: "
      version="$screen"
    elif [ -n "$tmux" ] && [ -n "$TMUX" ]; then
      shell="TMUX: "
      version="$tmux"
    elif [ -n "$bash" ]; then
      shell="bash: "
      version="$bash"
    else
      shell="$(basename ${TERM:-$SHELL}) "
      version="$(eval "$shell" --version 2>/dev/null | tr ' ' '\n' | grep -E '[0-9.]' | head -n1 | grep '^' || echo '1.0')"
    fi
    [ -n "$SSH_CONNECTION" ] && shell="${shell}${version}: $(printf '%s' "via SSH ")" || shell="${shell}${version}"
    printf "%s" "${BG_BLUE}${FG_BLACK}${shell}${RESET}"
  }
  # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  # Add bin to path
  ___add_bin_path() {
    if [ -d "$PWD/bin" ]; then
      if [ -z "$RESET_PATH" ]; then
        export RESET_PATH="$PATH"
        export PATH="$PWD/bin:$RESET_PATH"
      fi
    elif [ -n "$RESET_PATH" ]; then
      export PATH="$RESET_PATH"
      unset RESET_PATH
    fi
  }
  # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  # Change cursor
  ___set_cursor() {
    printf "\x1b[\x35 q" 2>/dev/null
    printf "\e]12;cyan\a" 2>/dev/null
  }
  # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  # Add PROMPT Message
  __ps1_additional() {
    if [ -n "$PS1_ADD" ]; then
      printf "%s" "${BG_BLACK:-$ADD_BGCOLOR}${FG_GREEN:-$ADD_FG}|${PS1_ADD:-}${RESET:-$ADD_RESET}"
    fi
  }
  __additional_msg() {
    __git_prompt_message_warn
    __ps1_additional
  }
  # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  # PROMPT
  __title_info() {
    echo -ne "${USER}@${HOSTNAME}:${PWD//$HOME/\~}"
  }
  # Add all additional pre commands here command
  __pre_prompt_command() {
    local EXIT=$? # Keep this here as it is needed for prompt
    ___time_it
    ___wakatime_prompt
    ___set_cursor
    return $EXIT
  }
  # Add all additional post commands here command
  __post_prompt_command() {
    true
  }
  # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
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
  # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  ps1() {
    local EXIT=$?
    if [ $EXIT -eq 0 ]; then
      local BG_EXIT="$BG_DARK_GREEN"
      local PS_SYMBOL="${PS_SYMBOL:- 😇 }"
    else
      local BG_EXIT="$BG_RED"
      local PS_SYMBOL=" 😔 ${BG_RED}E:${EXIT}${RESET}"
    fi
    [ -n "$NEW_PS_SYMBOL" ] && PS_SYMBOL="$NEW_PS_SYMBOL" && unset NEW_PS_SYMBOL
    [ -n "$NEW_BG_EXIT" ] && BG_EXIT="$NEW_BG_EXIT" && unset NEW_BG_EXIT
    BASHRC_GITDIR="$(git rev-parse --show-toplevel 2>/dev/null | grep '^' || echo "${CDD_CWD_DIR:-$PWD}")"

    ___add_bin_path
    __ifdate && ___date_show
    __ifwakatime && ___wakatime_show
    COLUMNS_COUNT="${WAKA_PROMPT_COUNT:-0}-${DATETIME_PROMPT_COUNT:-0}-1"
    PS_LINE="$(printf -- '%.0s' {4..2000})"
    PS_FILL="${PS_LINE:0:$((COLUMNS - 1))}"
    PS_TIME="\[\033[\$((COLUMNS-${COLUMNS_COUNT}))G\]${WAKA_PROMPT_MESSAGE}${DATETIME_PROMPT_MESSAGE}"
    PS1="\${PS_FILL}\[\033[0G\]$RESET"
    PS1+="$(__prompt_version)"
    PS1+="${BG_PURPLE}${FG_GRAY1}$(__ifphp && __php_info)${RESET}"
    PS1+="${BG_DARK_RED}${FG_GRAY1}$(__ifruby && __ruby_info)${RESET}"
    PS1+="${BG_DEEP_GREEN}$FG_GRAY1$(__ifnode && __node_info)${RESET}"
    PS1+="${BG_RED}${FG_BLACK}$(__ifpython && __python_info)${RESET}"
    PS1+="${BG_PURPLE}${FG_BLACK}$(__ifperl && __perl_info)${RESET}"
    PS1+="${BG_MAGENTA}${FG_BLACK}$(__iflua && __lua_info)${RESET}"
    PS1+="${BG_RED}${FG_BLACK}$(__ifrust && __rust_info)${RESET}"
    PS1+="${BG_YELLOW}${FG_BLACK}$(__ifgo && __go_info)${RESET}"
    PS1+="${BG_DARK_RED}${FG_BLACK}$(__ifgit && __git_info)${RESET}"
    PS1+="${BG_PURPLE}${FG_BLACK}${PS_TIME}$RESET\n"
    PS1+="${BG_GRAY2}${FG_BLACK}\u@\H: $BG_DARK_GREEN\w:$RESET$(__additional_msg)\n"
    if [ $USER == root ] || [ $UID == 0 ]; then
      PS1+="${BG_EXIT}${FG_BLACK}$(___time_show)Jobs:[\j]$BG_GRAY1${PS1_ADD_PROMPT:-}$PS_SYMBOL$RESET$ "
    else
      PS1+="${BG_EXIT}${FG_BLACK}$(___time_show)Jobs:[\j]$BG_GRAY1${PS1_ADD_PROMPT:-}$PS_SYMBOL$RESET: "
    fi
  }
  # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  PROMPT_COMMAND="__pre_prompt_command;ps1;title;__post_prompt_command;history -a && history -r; "
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
bashprompt 2>/dev/null
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# end
