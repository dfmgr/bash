#!/usr/bin/env bash

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# @Author      : Jason
# @Contact     : casjaysdev@casjay.net
# @File        : git.bash
# @Created     : Mon, Dec 31, 2019, 00:00 EST
# @License     : WTFPL
# @Copyright   : Copyright (c) CasjaysDev
# @Description : functions for git
#
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

function git() {
  command git "$@"
  if [[ "$1" == "init" && "$@" != *"--help"* ]]; then
    git symbolic-ref HEAD refs/heads/main
  fi
}


# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

function hub() {
  if [[ "$1" == "default-branch" && "$@" != *"--help"* ]]; then
    local BRANCH="${2:-main}"
    git checkout -b "$BRANCH" 2>/dev/null || git checkout "$BRANCH"
    git push origin "$BRANCH:$BRANCH" 1>/dev/null
    hub api repos/{owner}/{repo} -X PATCH -F default_branch="$BRANCH" 1> /dev/null
    git branch -D master 2>/dev/null
    git push origin :master 2>/dev/null
  else
    command hub "$@"
  fi
}

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
