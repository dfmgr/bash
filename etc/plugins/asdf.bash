#!/usr/bin/env bash
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# asdf
if [ -n "$BASH_VERSION" ]; then
  if [ -f ~/.local/share/asdf/asdf.sh ]; then
    . ~/.local/share/asdf/asdf.sh
  fi

fi
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# end
