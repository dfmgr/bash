#!/usr/bin/env sh

case "$(uname -s)" in
CYGWIN* | MINGW32* | MSYS* | MINGW*)
  if ls "$HOME"/.config/shell/profile/*.win 1>/dev/null 2>&1; then
    for f in "$HOME"/.config/shell/profile/*.win; do
      source "$f"
    done
  elif ls "$HOME"/.config/bash/profile/*.win 1>/dev/null 2>&1; then
    for f in "$HOME"/.config/bash/profile/*.win; do
      source "$f"
    done    
  fi
  ;;
Darwin)
  if ls "$HOME"/.config/shell/profile/*.mac 1>/dev/null 2>&1; then
    for f in "$HOME"/.config/shell/profile/*.mac; do
      source "$f"
    done
  elif ls "$HOME"/.config/bash/profile/*.mac 1>/dev/null 2>&1; then
    for f in "$HOME"/.config/bash/profile/*.mac; do
      source "$f"
    done
  fi
  ;;
Linux)
  if ls "$HOME"/.config/shell/profile/*.lin 1>/dev/null 2>&1; then
    for f in "$HOME"/.config/shell/profile/*.lin; do
      source "$f"
    done
  elif ls "$HOME"/.config/bash/profile/*.lin 1>/dev/null 2>&1; then
    for f in "$HOME"/.config/bash/profile/*.lin; do
      source "$f"
    done
  fi
  ;;
*)
  echo -e "\t\tUnknown OS or OS not supported"
  ;;
esac
