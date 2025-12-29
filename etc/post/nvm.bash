#!/usr/bin/env bash
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
##@Version       : 202108030255-git
# @Author        : casjay
# @Contact       : casjay
# @License       : LICENSE.md
# @ReadME        : nvm.bash --help
# @Copyright     : Copyright: (c) 2021 casjay, casjay
# @Created       : Tuesday, Aug 03, 2021 03:05 EDT
# @File          : nvm.bash
# @Description   : node version manager with lazy loading for fast shell startup
# @TODO          :
# @Other         :
# @Resource      :
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# Lazy load nvm - only load when nvm/node/npm/npx commands are actually used
# This dramatically improves shell startup time (NVM takes 1-3 seconds to load)
if { [ -z "$NODE_MANAGER" ] || [ "$NODE_MANAGER" = "nvm" ]; } && [ -n "$NVM_DIR" ] && [ -f "$NVM_DIR/nvm.sh" ]; then
  # Add default node to PATH if it exists (provides node/npm without loading nvm)
  if [ -d "$NVM_DIR/versions/node" ]; then
    __nvm_default_node=$(ls -1 "$NVM_DIR/versions/node" 2>/dev/null | sort -V | tail -1)
    if [ -n "$__nvm_default_node" ] && [ -d "$NVM_DIR/versions/node/$__nvm_default_node/bin" ]; then
      export PATH="$NVM_DIR/versions/node/$__nvm_default_node/bin:$PATH"
    fi
    unset __nvm_default_node
  fi
  # Lazy load function - loads nvm on first use
  __load_nvm() {
    unset -f nvm node npm npx 2>/dev/null
    . "$NVM_DIR/nvm.sh"
    if [ -f "$NVM_DIR/bash_completion" ]; then
      . "$NVM_DIR/bash_completion"
    fi
  }
  # Create wrapper functions that load nvm then run the command
  nvm() { __load_nvm && nvm "$@"; }
  node() { __load_nvm && node "$@"; }
  npm() { __load_nvm && npm "$@"; }
  npx() { __load_nvm && npx "$@"; }
fi
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
