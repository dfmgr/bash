#!/usr/bin/env sh

case "$(uname -s)" in
CYGWIN* | MINGW32* | MSYS* | MINGW*)
  if [ -f "$HOME/.config/shell/exports/00-default.win" ]; then
    source "$HOME/.config/shell/exports/00-default.win"
  elif [ -f "$HOME/.config/bash/exports/00-default.win" ]; then
    source "$HOME/.config/bash/exports/00-default.win"
  fi
  ;;
Darwin)
  if [ -f "$HOME/.config/shell/exports/00-default.mac" ]; then
    source "$HOME/.config/shell/exports/00-default.mac"
  elif [ -f "$HOME/.config/bash/exports/00-default.mac" ]; then
    source "$HOME/.config/bash/exports/00-default.mac"
  fi
  ;;
Linux)
  if [ -f "$HOME/.config/shell/exports/00-default.lin" ]; then
    source "$HOME/.config/shell/exports/00-default.lin"
  elif [ -f "$HOME/.config/bash/exports/00-default.lin" ]; then
    source "$HOME/.config/bash/exports/00-default.lin"
  fi
  ;;
*)
  echo -e "\t\tUnknown OS or OS not supported"
  ;;
esac
