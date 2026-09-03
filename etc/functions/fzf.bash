#!/usr/bin/env bash
# shellcheck shell=bash
# - - - - - - - - - - - - - - - - - - - - - - - -
##@Version           :  202609031422-git
# @@Author           :  Jason Hempstead
# @@Contact          :  git-admin@casjaysdev.pro
# @@License          :  WTFPL
# @@ReadME           :  README.md
# @@Copyright        :  Copyright: (c) 2021 Jason Hempstead, Casjays Developments
# @@Created          :  Thursday, Mar 25, 2021 16:42 EDT
# @@File             :  fzf.bash
# @@Description      :  fzf color options and helper functions
# @@Changelog        :  standardized header to WTFPL @@-field template
# @@TODO             :
# @@Other            :
# @@Resource         :
# @@Terminal App     :  no
# @@sudo/root        :  no
# @@Template         :  shell/bash
# - - - - - - - - - - - - - - - - - - - - - - - -
# shellcheck disable=SC1001,SC1003,SC2001,SC2003,SC2016,SC2031,SC2090,SC2115,SC2120,SC2155,SC2199,SC2229,SC2317,SC2329
# - - - - - - - - - - - - - - - - - - - - - - - -
VERSION="202609031422-git"
export FZF_DEFAULT_OPTS="$FZF_DEFAULT_OPTS --color=dark --color=fg:-1,bg:-1,hl:#5fff87,fg+:-1,bg+:-1,hl+:#ffaf5f --color=info:#af87ff,prompt:#5fff87,pointer:#ff87d7,marker:#ff87d7,spinner:#ff87d7"
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
__fd() { command -v fd || command -v fdfind || return 1; }
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
_fzf_complete_ssh_notrigger() { FZF_COMPLETION_TRIGGER='' _fzf_host_completion; }
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
open_with_fzf() {
  [ -n "$(type -P fzf-tmux)" ] || return 1
  local files editor="${EDITOR:-myeditor}" IFS=$'\n' files=($(fzf-tmux --query="$1" --multi --select-1 --exit-0))
  [ -n "${files[*]}" ] && $editor "${files[@]}"
}
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# end
