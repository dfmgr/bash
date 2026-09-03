#!/usr/bin/env bash
# shellcheck shell=bash
# - - - - - - - - - - - - - - - - - - - - - - - -
##@Version           :  202609031422-git
# @@Author           :  Jason
# @@Contact          :  git-admin@casjaysdev.pro
# @@License          :  WTFPL
# @@ReadME           :  README.md
# @@Copyright        :  Copyright: (c) 2021 Jason Hempstead, Casjays Developments
# @@Created          :  Tuesday Aug 03, 2021 03:45:21 EDT
# @@File             :  zoxide.bash
# @@Description      :  loads zoxide, or offers to install it on first use
# @@Changelog        :  standardized header to WTFPL @@-field template
# @@TODO             :
# @@Other            :
# @@Resource         :  https://github.com/ajeetdsouza/zoxide
# @@Terminal App     :  no
# @@sudo/root        :  no
# @@Template         :  shell/bash
# - - - - - - - - - - - - - - - - - - - - - - - -
# shellcheck disable=SC1001,SC1003,SC2001,SC2003,SC2016,SC2031,SC2090,SC2115,SC2120,SC2155,SC2199,SC2229,SC2317,SC2329
# - - - - - - - - - - - - - - - - - - - - - - - -
VERSION="202609031422-git"
if command -v zoxide &>/dev/null; then
  eval "$(zoxide init bash)"
else
  zoxide() {
    unset -f zoxide
    if [ -n "$ZOXIDE_AUTO_INSTALL" ]; then
      curl -q -LSsf "https://webinstall.dev/zoxide" | bash && eval "$(zoxide init bash)" && zoxide "$@" || return 1
    else
      printf '%s\n' "zoxide is not installed. Install it with: curl -LSsf https://webinstall.dev/zoxide | bash" >&2
      printf '%s\n' "Or set ZOXIDE_AUTO_INSTALL=1 to install it automatically on next use." >&2
      return 1
    fi
  }
fi
# - - - - - - - - - - - - - - - - - - - - - - - -
