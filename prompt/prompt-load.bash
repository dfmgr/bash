#!/usr/bin/env sh

case "$(uname -s)" in
CYGWIN* | MINGW32* | MSYS* | MINGW*)
  if [ "$(ls $HOME/.config/bash/prompt/*.win 2>/dev/null | wc -l)" != 0 ]; then
    for f in $HOME/.config/bash/prompt/*.win; do
      source "$f"
    done    
  fi
  ;;
Darwin)
  if [ "$(ls $HOME/.config/bash/prompt/*.mac 2>/dev/null | wc -l)" != 0 ]; then
    for f in $HOME/.config/bash/prompt/*.mac; do
      source "$f"
    done
  fi
  ;;
Linux)
  if [ "$(ls $HOME/.config/bash/prompt/*.lin 2>/dev/null | wc -l)" != 0 ]; then
    for f in $HOME/.config/bash/prompt/*.lin; do
      source "$f"
    done
  fi
  ;;
*)
  ;;
esac
