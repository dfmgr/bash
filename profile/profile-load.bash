#!/usr/bin/env sh

case "$(uname -s)" in
CYGWIN* | MINGW32* | MSYS* | MINGW*)
  if ls "$HOME/.config/shell/profile/00-default.win" 1>/dev/null 2>&1; then
    source "$HOME/.config/shell/profile/00-default.win"
  elif ls "$HOME/.config/bash/profile/00-default.win" 1>/dev/null 2>&1; then
    source "$HOME/.config/bash/profile/00-default.win"
  fi
  ;;
Darwin)
  if ls "$HOME/.config/shell/profile/00-default.mac" 1>/dev/null 2>&1; then
    source "$HOME/.config/shell/profile/00-default.mac"
  elif ls "$HOME/.config/bash/profile/00-default.mac" 1>/dev/null 2>&1; then
    source "$HOME/.config/bash/profile/00-default.mac"
  fi
  ;;
Linux)
  if ls "$HOME/.config/shell/profile/00-default.lin" 1>/dev/null 2>&1; then
    source "$HOME/.config/shell/profile/00-default.lin"
  elif ls "$HOME/.config/bash/profile/00-default.lin" 1>/dev/null 2>&1; then
    source "$HOME/.config/bash/profile/00-default.lin"
  fi
  ;;
*)
  echo -e "\t\tUnknown OS or OS not supported"
  ;;
esac
