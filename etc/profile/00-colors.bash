#!/usr/bin/env bash
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
##@Version       : 202103251632-git
# @Author        : Jason Hempstead
# @Contact       : jason@casjaysdev.pro
# @License       : LICENSE.md
# @ReadME        : 00-colors.bash --help
# @Copyright     : Copyright: (c) 2021 Jason Hempstead, CasjaysDev
# @Created       : Thursday, Mar 25, 2021 17:59 EDT
# @File          : 00-colors.bash
# @Description   :
# @TODO          :
# @Other         :
# @Resource      :
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# colors initialization
color_prompt=yes
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# Set background type (optimized with early exit)
# User can override by setting: export TERMINAL_BACKGROUND="light" or "dark"
if [ -n "$TERMINAL_BACKGROUND" ]; then
  TERMINAL_BG="$TERMINAL_BACKGROUND"
elif [ -n "$COLORFGBG" ]; then
  # Try COLORFGBG variable (set by some terminals)
  # Format is typically "15;0" where second number is background
  # 0-7 = dark, 8-15 = light
  bg_num="${COLORFGBG##*;}"
  # Validate that bg_num is actually a number before comparison
  case "$bg_num" in
    ''|*[!0-9]*) TERMINAL_BG="dark" ;;  # Not a number, default to dark
    *)
      if [ "$bg_num" -ge 8 ]; then
        TERMINAL_BG="light"
      else
        TERMINAL_BG="dark"
      fi
      ;;
  esac
  unset bg_num
else
  # Default to dark (most common for developers)
  TERMINAL_BG="dark"
fi
export TERMINAL_BG
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# Reset
NC="$(tput sgr0 2>/dev/null)"
RESET="$(tput sgr0 2>/dev/null)"
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# Bold
BOLD="$(tput bold 2>/dev/null)"
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# Regular Colors (adaptive based on terminal background)
# Bright Black (Gray) - better than pure black
BLACK="\033[0;90m"
# Red - adaptive: bright red on dark, normal red on light
if [ "$TERMINAL_BG" = "dark" ]; then
  RED="\033[0;91m"
else
  RED="\033[0;31m"
fi
GREEN="\033[0;32m"
# Bright Yellow - better visibility
YELLOW="\033[1;33m"
# Bright Blue - readable on dark backgrounds
BLUE="\033[1;34m"
PURPLE="\033[0;35m"
CYAN="\033[0;36m"
# White - adaptive: bright white on dark, gray on light
if [ "$TERMINAL_BG" = "dark" ]; then
  WHITE="\033[0;97m"
else
  WHITE="\033[0;37m"
fi
# Bright Yellow (Orange) - better visibility
ORANGE="\033[1;33m"
# Light Red - always bright for visibility
LIGHTRED='\033[1;91m'
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# Bold (adaptive based on terminal background)
# Bright Black (Gray) - readable on both
BBLACK="\033[1;90m"
# Bold Red - always use bright for visibility
BRED="\033[1;91m"
BGREEN="\033[1;32m"
# Bright Bold Yellow - maximum visibility
BYELLOW="\033[1;93m"
# Bright Bold Blue - readable on dark
BBLUE="\033[1;94m"
BPURPLE="\033[1;35m"
BCYAN="\033[1;36m"
# Bold White - adaptive
if [ "$TERMINAL_BG" = "dark" ]; then
  BWHITE="\033[1;97m"
else
  BWHITE="\033[1;37m"
fi
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
# end
