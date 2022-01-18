#!/usr/bin/env bash
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
##@Version       : 202103251632-git
# @Author        : Jason Hempstead
# @Contact       : jason@casjaysdev.com
# @License       : LICENSE.md
# @ReadME        : 00-functions.bash --help
# @Copyright     : Copyright: (c) 2021 Jason Hempstead, CasjaysDev
# @Created       : Thursday, Mar 25, 2021 16:41 EDT
# @File          : 00-functions.bash
# @Description   :
# @TODO          :
# @Other         :
# @Resource      :
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# Icons
ICON_INFO="[ ℹ️ ]"
ICON_GOOD="[ ✔ ]"
ICON_WARN="[ ❗ ]"
ICON_ERROR="[ ✖ ]"
ICON_QUESTION="[ ❓ ]"
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
printf_color() { printf "%b" "$(tput setaf "$2" 2>/dev/null)" "$1" "$(tput sgr0 2>/dev/null)"; }
printf_normal() { printf_color "\t\t$1\n" "0"; }
printf_green() { printf_color "\t\t$1\n" 2; }
printf_red() { printf_color "\t\t$1\n" 1; }
printf_purple() { printf_color "\t\t$1\n" 5; }
printf_yellow() { printf_color "\t\t$1\n" 3; }
printf_blue() { printf_color "\t\t$1\n" 4; }
printf_cyan() { printf_color "\t\t$1\n" 6; }
printf_info() { printf_color "\t\t$ICON_INFO $1\n" 3; }
printf_success() { printf_color "\t\t$ICON_GOOD $1\n" 2; }
printf_error() { printf_color "\t\t$ICON_ERROR $1 $2\n" 1; }
printf_warning() { printf_color "\t\t$ICON_WARN $1\n" 3; }
printf_question() { printf_color "\t\t$ICON_QUESTION $1 " 6; }
printf_error_stream() { while read -r line; do printf_error "↳ ERROR: $line"; done; }
printf_execute_success() { printf_color "\t\t$ICON_ERROR $1  \n" 2; }
printf_execute_error() { printf_color "\t\t$ICON_ERROR $1 $2 \n" 1; }
printf_execute_result() {
  if [ "$1" -eq 0 ]; then printf_execute_success "$2"; else printf_execute_error "$2"; fi
  return "$1"
}
printf_execute_error_stream() { while read -r line; do printf_execute_error "↳ ERROR: $line"; done; }

printf_exit() {
  test -n "$1" && test -z "${1//[0-9]/}" && local color="$1" && shift 1 || local color="1"
  local msg="$*"
  shift
  printf_color "\t\t$msg" "$color"
  echo ""
  return 0
}

printf_help() {
  test -n "$1" && test -z "${1//[0-9]/}" && local color="$1" && shift 1 || local color="4"
  local msg="$*"
  shift
  echo ""
  printf_color "\t\t$msg\n" "$color"
  echo ""
  return 0
}

printf_pause() {
  test -n "$1" && test -z "${1//[0-9]/}" && local color="$1" && shift 1 || local color="5"
  local msg="${*:-Press any key to continue}"
  printf_color "\t\t$msg " "$color"
  read -r -n 1 -s
  printf "\n"
}

printf_custom() {
  test -n "$1" && test -z "${1//[0-9]/}" && local color="$1" && shift 1 || local color="5"
  local msg="$*"
  shift
  printf_color "\t\t$msg" "$color"
  echo ""
}

printf_read() {
  set -o pipefail
  test -n "$1" && test -z "${1//[0-9]/}" && local color="$1" && shift 1 || local color="6"
  while read -r line; do
    printf_color "\t\t$line" "$color"
  done
  printf "\n"
  set +o pipefail
}

printf_readline() {
  set -o pipefail
  test -n "$1" && test -z "${1//[0-9]/}" && local color="$1" && shift 1 || local color="6"
  while read -r line; do
    printf_color "\t\t$line\n" "$color"
  done
  set +o pipefail
}

printf_question() {
  test -n "$1" && test -z "${1//[0-9]/}" && local color="$1" && shift 1 || local color="4"
  local msg="$*"
  shift
  printf_color "\t\t$ICON_QUESTION $msg? " "$color"
}

printf_custom_question() {
  test -n "$1" && test -z "${1//[0-9]/}" && local color="$1" && shift 1 || local color="1"
  local msg="$*"
  shift
  printf_color "\t\t$msg " "$color"
}

printf_answer() {
  read -e -r -n "${2:-120}" -s "${1:-__ANSWER}"
  history -s "${1:-$__ANSWER}"
}

#printf_read_question "color" "message" "maxLines" "answerVar"
printf_read_question() {
  test -n "$1" && test -z "${1//[0-9]/}" && local color="$1" && shift 1 || local color="1"
  local msg="$1" && shift 1
  local lines="${1:-120}" && shift 1
  local reply="${1:-$__ANSWER}" && shift 1
  printf_color "\t\t$msg " "$color"
  printf_answer "$reply" "$lines"
}

printf_answer_yes() {
  [[ "${1:-$__ANSWER}" =~ ${2:-^[Yy]$} ]] && return 0 || return 1
}

printf_head() {
  test -n "$1" && test -z "${1//[0-9]/}" && local color="$1" && shift 1 || local color="6"
  local msg1="$1" && shift 1
  local msg2="$1" && shift 1 || msg2=
  local msg3="$1" && shift 1 || msg3=
  local msg4="$1" && shift 1 || msg4=
  local msg5="$1" && shift 1 || msg5=
  local msg6="$1" && shift 1 || msg6=
  local msg7="$1" && shift 1 || msg7=
  shift
  [ -z "$msg1" ] || printf_color "\t\t##################################################\n" "$color"
  [ -z "$msg1" ] || printf_color "\t\t$msg1\n" "$color"
  [ -z "$msg2" ] || printf_color "\t\t$msg2\n" "$color"
  [ -z "$msg3" ] || printf_color "\t\t$msg3\n" "$color"
  [ -z "$msg4" ] || printf_color "\t\t$msg4\n" "$color"
  [ -z "$msg5" ] || printf_color "\t\t$msg5\n" "$color"
  [ -z "$msg6" ] || printf_color "\t\t$msg6\n" "$color"
  [ -z "$msg7" ] || printf_color "\t\t$msg7\n" "$color"
  [ -z "$msg1" ] || printf_color "\t\t##################################################\n" "$color"
}
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# use grc if it's installed or execute the command direct
if [[ -f "$(command -v grc)" ]]; then
  if [[ "$USEGRC" = "yes" ]]; then
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
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# generate random strings
if [[ -z "$(command -v random-string)" ]]; then
  random-string() {
    cat '/dev/urandom' | tr -dc 'a-zA-Z0-9' | fold -w "${1:-64}" | head -n 1
  }
fi
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
if [[ -z "$(command -v mkpasswd)" ]]; then
  mkpasswd() {
    cat '/dev/urandom' | tr -dc '[:print:]' | tr -d '[:space:]\042\047\134' | fold -w "${1:-64}" | head -n 1
  }
fi
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
cd() {
  [[ $# -gt 1 ]] && { printf_red "Usage: cd or cd directory" && return 1; }
  if [[ -n "$CDD_CWD_DIR" ]]; then
    [[ $# -eq 0 ]] && CD_DIR="$CDD_CWD_DIR" || CD_DIR="$CDD_CWD_DIR/${*:-}"
    cd_cdd "$CDD_CWD_DIR"
  else
    local CD_DIR="${1:-$HOME}"
    [ -n "$CD_DIR" ] && [ -d "$CD_DIR" ] || mkdir -p "$CD_DIR"
    builtin cd "$CD_DIR" || { printf_red "failed to cd into $CD_DIR" && return 1; }
  fi
}
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# the fuck
fuck() {
  TF_CMD=$(
    TF_ALIAS=fuck \
      PYTHONIOENCODING=utf-8 \
      TF_SHELL_ALIASES=$(alias)
    thefuck "$(fc -ln -1)"
  ) && eval "$TF_CMD" && history -s "$TF_CMD"
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
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# end
