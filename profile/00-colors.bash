#!/usr/bin/env bash
####

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# colors initialization
color_prompt=yes

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# Reset
NC="$(tput sgr0 2>/dev/null)"
RESET="$(tput sgr0 2>/dev/null)"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# Bold
BOLD="$(tput bold 2>/dev/null)"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# Regular Colors
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

# Bold
BBLACK="\033[1;30m"  # Black
BRED="\033[1;31m"    # Red
BGREEN="\033[1;32m"  # Green
BYELLOW="\033[1;33m" # Yellow
BBLUE="\033[1;34m"   # Blue
BPURPLE="\033[1;35m" # Purple
BCYAN="\033[1;36m"   # Cyan
BWHITE="\033[1;37m"  # White

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# Underline
UBLACK="\033[4;30m"  # Black
URED="\033[4;31m"    # Red
UGREEN="\033[4;32m"  # Green
UYELLOW="\033[4;33m" # Yellow
UBLUE="\033[4;34m"   # Blue
UPURPLE="\033[4;35m" # Purple
UCYAN="\033[4;36m"   # Cyan
UWHITE="\033[4;37m"  # White

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# Background
ON_BLACK="\033[40m"  # Black
ON_RED="\033[41m"    # Red
ON_GREEN="\033[42m"  # Green
ON_YELLOW="\033[43m" # Yellow
ON_BLUE="\033[44m"   # Blue
ON_PURPLE="\033[45m" # Purple
ON_CYAN="\033[46m"   # Cyan
ON_WHITE="\033[47m"  # White

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# High Intensity
IBLACK="\033[0;90m"  # Black
IRED="\033[0;91m"    # Red
IGREEN="\033[0;92m"  # Green
IYELLOW="\033[0;93m" # Yellow
IBLUE="\033[0;94m"   # Blue
IPURPLE="\033[0;95m" # Purple
ICYAN="\033[0;96m"   # Cyan
IWHITE="\033[0;97m"  # White

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# Bold High Intensity
BIBLACK="\033[1;90m"  # Black
BIRED="\033[1;91m"    # Red
BIGREEN="\033[1;92m"  # Green
BIYELLOW="\033[1;93m" # Yellow
BIBLUE="\033[1;94m"   # Blue
BIPURPLE="\033[1;95m" # Purple
BICYAN="\033[1;96m"   # Cyan
BIWHITE="\033[1;97m"  # White

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# High Intensity backgrounds
ON_IBLACK="\033[0;100m"  # Black
ON_IRED="\033[0;101m"    # Red
ON_IGREEN="\033[0;102m"  # Green
ON_IYELLOW="\033[0;103m" # Yellow
ON_IBLUE="\033[0;104m"   # Blue
ON_IPURPLE="\033[0;105m" # Purple
ON_ICYAN="\033[0;106m"   # Cyan
ON_IWHITE="\033[0;107m"  # White

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

printf_color() { printf "%b" "$(tput setaf "$2" 2>/dev/null)" "$1" "$(tput sgr0 2>/dev/null)"; }
printf_normal() { printf_color "\t\t$1\n" "0"; }
printf_green() { printf_color "\t\t$1\n" 2; }
printf_red() { printf_color "\t\t$1\n" 1; }
printf_purple() { printf_color "\t\t$1\n" 5; }
printf_yellow() { printf_color "\t\t$1\n" 3; }
printf_blue() { printf_color "\t\t$1\n" 4; }
printf_cyan() { printf_color "\t\t$1\n" 6; }
printf_info() { printf_color "\t\t[ ℹ️ ] $1\n" 3; }
printf_exit() {
  printf_color "\t\t$1\n" 1
  return 1
}
printf_help() { printf_color "\t\t$1\n" 1; }
printf_read() { printf_color "\t\t$1" 5; }
printf_success() { printf_color "\t\t[ ✔ ] $1\n" 2; }
printf_error() { printf_color "\t\t[ ✖ ] $1 $2\n" 1; }
printf_warning() { printf_color "\t\t[ ❗ ] $1\n" 3; }
printf_question() { printf_color "\t\t[ ❓ ] $1 [❓] " 6; }
printf_error_stream() { while read -r line; do printf_error "↳ ERROR: $line"; done; }
printf_execute_success() { printf_color "\t\t[ ✔ ] $1 [ ✔ ] \n" 2; }
printf_execute_error() { printf_color "\t\t[ ✖ ] $1 $2 [ ✖ ] \n" 1; }
printf_execute_result() {
  if [ "$1" -eq 0 ]; then printf_execute_success "$2"; else printf_execute_error "$2"; fi
  return "$1"
}
printf_execute_error_stream() { while read -r line; do printf_execute_error "↳ ERROR: $line"; done; }

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

#END
