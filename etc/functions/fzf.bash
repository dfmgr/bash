#!/usr/bin/env bash
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
__fd() { command -v fd || command -v fdfind || return; }
open_with_fzf() { __fd -t f -H -I | fzf -m --preview="xdg-mime query default {}" | xargs -ro -d "\n" xdg-open 2>&- || return 1; }
#cd_with_fzf() {
#    cd $HOME && cd "$(__fd -t d | fzf --preview="tree -L 1 {}" --bind="space:toggle-preview" --preview-window=:hidden)"
#}
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# end
