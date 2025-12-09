#!/usr/bin/env bash
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
##@Version       : 202103251632-git
# @Author        : Jason Hempstead
# @Contact       : jason@casjaysdev.pro
# @License       : LICENSE.md
# @ReadME        : git.bash --help
# @Copyright     : Copyright: (c) 2021 Jason Hempstead, CasjaysDev
# @Created       : Thursday, Mar 25, 2021 16:43 EDT
# @File          : git.bash
# @Description   :
# @TODO          :
# @Other         :
# @Resource      :
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
git_prompt_message() {
  if [ -f "$HOME/.config/bash/noprompt/git_message" ]; then
    return 0
  else
    if [ "$(git rev-parse --is-inside-git-dir)" == "true" ]; then
      printf_red "This message will only appear once per repo:"
      printf_custom "3" "This can be disabled by adding ignoredirmessage to your gitignore"
      printf_custom "3" "echo ignoredirmessage >> .gitignore or by running"
      printf_custom "3" "touch \$HOME/.config/bash/noprompt/git_message"
    fi
  fi
}
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
get_git_repository_details() {
  local branchName=""
  local tmp=""
  ! git rev-parse &>/dev/null && return
  [ "$(git rev-parse --is-inside-git-dir)" == "true" ] && return
  if ! git diff --quiet --ignore-submodules --cached; then tmp="$tmp+"; fi
  if ! git diff-files --quiet --ignore-submodules --; then tmp="$tmp!"; fi
  if [ -n "$(git ls-files --others --exclude-standard)" ]; then tmp="$tmp?"; fi
  if git rev-parse --verify refs/stash &>/dev/null; then tmp="$tmp$"; fi
  [ -n "$tmp" ] && tmp=" [$tmp]"
  branchName="$(printf "%s" "$(git rev-parse --abbrev-ref HEAD 2>/dev/null ||
    git rev-parse --short HEAD 2>/dev/null ||
    printf " (unknown)")" | tr -d "\n")"
  printf "%s" "$1$branchName$tmp"
}
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
git() {
  command git "$@"
  if [[ "$1" == "init" && "$*" != *"--help"* ]]; then
    git symbolic-ref HEAD refs/heads/main
  fi
}
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
hub() {
  builtin type -P hub &>/dev/null || return 0
  if [[ "$1" == "default-branch" && "$*" != *"--help"* ]]; then
    local BRANCH="${2:-main}"
    git checkout -b "$BRANCH" 2>/dev/null || git checkout "$BRANCH"
    git push origin "$BRANCH:$BRANCH" 1>/dev/null
    hub api repos/{owner}/{repo} -X PATCH -F default_branch="$BRANCH" 1>/dev/null
    git branch -D master 2>/dev/null
    git push origin :master 2>/dev/null
  else
    command hub "$@"
  fi
}
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# end
