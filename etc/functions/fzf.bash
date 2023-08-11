#!/usr/bin/env bash
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
##@Version       : 202103251632-git
# @Author        : Jason Hempstead
# @Contact       : jason@casjaysdev.pro
# @License       : LICENSE.md
# @ReadME        : fzf.bash
# @Copyright     : Copyright: (c) 2021 Jason Hempstead, CasjaysDev
# @Created       : Thursday, Mar 25, 2021 16:42 EDT
# @File          : fzf.bash
# @Description   :
# @TODO          :
# @Other         :
# @Resource      :
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
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
