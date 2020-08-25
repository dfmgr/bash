#!/usr/bin/env bash

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# basher

if [ -n "$BASH_VERSION" ]; then
  if [ -d "$HOME/.local/share/bash/basher" ]; then
    export BASHER_ROOT="$HOME/.local/share/bash/basher"
    export PATH="$HOME/.local/share/bash/basher/bin:$PATH"
    if [ -f "$HOME/.local/share/bash/basher/bin/basher" ]; then
      eval "$(basher init - bash)"
    fi
  fi
fi

