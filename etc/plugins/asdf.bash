#!/usr/bin/env bash
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# asdf
if [ -n "$BASH_VERSION" ]; then
  if [ -d "$HOME/.local/share/misc/plugins/asdf" ]; then
    ASDF_DIR="$HOME/.local/share/misc/plugins/asdf"
    if [ -f "$ASDF_DIR/asdf.sh" ]; then
      . "$ASDF_DIR/asdf.sh"
    fi
    if [ -f "$ASDF_DIR/completions/asdf.bash" ]; then
      . "$ASDF_DIR/completions/asdf.bash"
    fi
  fi
fi
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# end
