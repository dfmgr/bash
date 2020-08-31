#!/usr/bin/env bash

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# @Author      : Jason
# @Contact     : casjaysdev@casjay.net
# @File        : 00.bash
# @Created     : Mon, Dec 23, 2019, 14:13 EST
# @License     : WTFPL
# @Copyright   : Copyright (c) CasjaysDev
# @Description : functions for bash login
#
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

NC="$(tput sgr0 2>/dev/null)"
RESET="$(tput sgr0 2>/dev/null)"
BLACK="\033[0;30m"    # Black
RED="\033[0;31m"      # Red
GREEN="\033[0;32m"    # Green
YELLOW="\033[0;33m"   # Yellow
BLUE="\033[0;34m"     # Blue
PURPLE="\033[0;35m"   # Purple
CYAN="\033[0;36m"     # Cyan
WHITE="\033[0;37m"    # White
ORANGE="\033[0;33m"   # Orange
LIGHTRED='\033[1;31m' # Light Red

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

printf_color() { printf "%b" "$(tput setaf "$2" 2>/dev/null)" "$1" "$(tput sgr0 2>/dev/null)"; }
printf_normal() { printf_color "\t\t$1\n" "$2"; }
printf_green() { printf_color "\t\t$1\n" 2; }
printf_red() { printf_color "\t\t$1\n" 1; }
printf_purple() { printf_color "\t\t$1\n" 5; }
printf_yellow() { printf_color "\t\t$1\n" 3; }
printf_blue() { printf_color "\t\t$1\n" 4; }
printf_cyan() { printf_color "\t\t$1\n" 6; }
printf_info() { printf_color "\t\t[ ℹ️ ] $1\n" 3; }
printf_help() { printf_color "\t\t$1\n" 1; }
printf_read() { printf_color "\t\t$1" 5; }
printf_success() { printf_color "\t\t[ ✔ ] $1\n" 2; }
printf_error() { printf_color "\t\t[ ✖ ] $1 $2\n" 1; }
printf_warning() { printf_color "\t\t[ ❗ ] $1\n" 3; }
printf_question() { printf_color "\t\t[ ❓ ] $1 [❓] " 6; }
printf_error_stream() { while read -r line; do printf_error "↳ ERROR: $line"; done; }
printf_execute_success() { printf_color "\t\t[ ✔ ] $1 [ ✔ ] \n" 2; }
printf_execute_error() { printf_color "\t\t[ ✖ ] $1 $2 [ ✖ ] \n" 1; }
printf_execute_error_stream() { while read -r line; do printf_execute_error "↳ ERROR: $line"; done; }

printf_execute_result() {
  if [ "$1" -eq 0 ]; then printf_execute_success "$2"; else printf_execute_error "$2"; fi
  return "$1"
}

printf_exit() {
  printf_color "\t\t$1\n" 1
  return 1
}

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

__tput() { tput $* 2>/dev/null; }
__whiletrue() { while true; do
  "$@"
  sleep 60
done; }

cmd_exists() {
  unalias "$1" >/dev/null 2>&1
  command -v "$1" >/dev/null 2>&1
}

rm_rf() { devnull rm -Rf "$@"; }
cp_rf() { if [ -e "$1" ]; then devnull cp -Rfa "$@"; fi; }
mv_f() { if [ -e "$1" ]; then devnull mv -f "$@"; fi; }
ln_rm() { devnull find "$HOME" -xtype l -delete; }
ln_sf() {
  devnull ln -sf "$@"
  ln_rm
}

devnull() { "$@" >/dev/null 2>&1; }
devnull1() { "$@" 1>/dev/null; }
devnull2() { "$@" 2>/dev/null; }
alias_function() { eval "${1}() $(declare -f "${2}" | sed 1d)"; }
set_trap() { trap -p "$1" | grep "$2" &>/dev/null || trap '$2' "$1"; }

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

returnexitcode() {
  local RETVAL="$?"
  if [ "$RETVAL" -eq 0 ]; then BG_EXIT="${BG_GREEN}"; else BG_EXIT="${BG_RED}"; fi
}

getexitcode() {
  local RETVAL="$?"
  local ERROR="Failed"
  local SUCCES="$1"
  EXIT="$RETVAL"
  if [ "$RETVAL" -eq 0 ]; then
    printf_success "$SUCCES"
    return 0
  else
    printf_error "$ERROR"
    return 1
  fi
  returnexitcode
}

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

answer_is_yes() { [[ "$REPLY" =~ ^[Yy]$ ]] && return 0 || return 1; }

ask() {
  printf_question "$1"
  read -r
}

ask_for_confirmation() {
  printf_question "$1"
  read -r -n 1
  printf ""
}

get_answer() { printf "%s" "$REPLY"; }

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# use grc if it's installed or execute the command direct

if ! cmd_exists grc; then
  if [[ USEGRC = "yes" ]]; then
    grc() {
      if [[ -f "$(command -v grc)" ]]; then
        #grc --colour=auto
        $(command -v grc) --colour=on "$@"
      else
        "$@"
      fi
    }
  fi
fi

#

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# generate random strings

if ! cmd_exists random-string; then
  random-string() {
    cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w ${1:-64} | head -n 1
  }
fi

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

if ! cmd_exists mkpasswd; then
  mkpasswd() {
    cat /dev/urandom | tr -dc [:print:] | tr -d '[:space:]\042\047\134' | fold -w ${1:-64} | head -n 1
  }
fi

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# the fuck

fuck() {
  TF_CMD=$(
    TF_ALIAS=fuck \
      PYTHONIOENCODING=utf-8 \
      TF_SHELL_ALIASES=$(alias)
    thefuck $(fc -ln -1)
  ) &&
    eval $TF_CMD && history -s $TF_CMD
}

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# Set OS TYPE

detectos() {
  OS="$(uname)"
  case $OS in
  'Linux')
    OS='Linux'
    ;;
  'FreeBSD')
    OS='FreeBSD'
    ;;
  'WindowsNT')
    OS='Windows'
    ;;
  'Darwin')
    OS='Mac'
    ;;
  'SunOS')
    OS='Solaris'
    ;;
  'AIX') ;;
  *) ;;
  esac
}

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

#Set OS Detection

detectostype() {
  arch=$(uname -m)
  kernel=$(uname -r)
  if [ -n "$(command -v lsb_release)" ]; then
    distroname=$(lsb_release -s -d)
  elif [ -f "/etc/os-release" ]; then
    distroname=$(grep PRETTY_NAME /etc/os-release | sed 's/PRETTY_NAME=//g' | tr -d '="')
  elif [ -f "/etc/debian_version" ]; then
    distroname="Debian $(cat /etc/debian_version)"
  elif [ -f "/etc/redhat-release" ]; then
    distroname=$(cat /etc/redhat-release)
  else
    distroname="$(uname -s) $(uname -r)"
  fi

  #Various Arch Distros
  if [[ "$distroname" =~ "ArcoLinux" ]] || [[ "$distroname" =~ "Arch" ]] || [[ "$distroname" =~ "BlackArch" ]]; then
    DISTRO=Arch
  #Raspberry pi
  elif [[ "$distroname" =~ "Raspbian" ]]; then
    DISTRO=Raspbian
  #Various RedHat Distros
  elif [[ "$distroname" =~ "Scientific" ]] || [[ "$distroname" =~ "RedHat" ]] || [[ "$distroname" =~ "CentOS" ]] || [[ "$distroname" =~ "Casjay" ]]; then
    DISTRO=RHEL
  #Various Debian Distros
  elif [[ "$distroname" =~ "Kali" ]] || [[ "$distroname" =~ "Parrot" ]] || [[ "$distroname" =~ "Debian" ]]; then
    DISTRO=Debian
    if [[ "$distroname" =~ "Debian" ]]; then
      CODENAME=$(lsb_release -a 2>/dev/null | grep Code | sed 's#Codename:##g' | awk '{print $1}')
    fi
    if [[ "$distroname" =~ "Kali" ]]; then
      CODENAME=kali
    fi
    if [[ "$distroname" =~ "Parrot" ]]; then
      CODENAME=parrot
    fi
  elif [[ "$distroname" =~ "Ubuntu" ]] || [[ "$distroname" =~ "Mint" ]] || [[ "$distroname" =~ "Elementary" ]] || [[ "$distroname" =~ "KDE neon" ]]; then
    DISTRO=Ubuntu
    CODENAME=$(lsb_release -a 2>/dev/null | grep Code | sed 's#Codename:##g' | awk '{print $1}')
  elif [[ "$distroname" =~ "Fedora" ]]; then
    DISTRO=Fedora
  fi

  if [ -f /etc/os-release ]; then
    DISTROID="$(grep ID_LIKE /etc/os-release | sed 's/^.*=//')"
  fi

}

# - -- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

detectos
detectostype
unset -f detectos detectostype

# - -- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
