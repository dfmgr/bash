#!/usr/bin/env bash

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# set path
PATH="/usr/local/bin:$PATH"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# Create directories
mkdir -p $HOME/.config/bash/noprompt >/dev/null 2>&1

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# Source System Bash

# Fedora/Redhat/CentOS
if [ -f /etc/bashrc ]; then
  source /etc/bashrc
fi

# Debian/Ubuntu/Arch/Mac/Win
if [ -f /etc/bash.bashrc ]; then
  source /etc/bash.bashrc
fi

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# source .profile

if [ -f "$HOME/.profile" ]; then
  source "$HOME/.profile"
fi

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

#source users functions

userbashfunctions() {
  local d=$(ls "$HOME"/.config/bash/functions/*.bash 2>/dev/null | wc -l)
  if [ "$d" != "0" ]; then
    for f in "$HOME"/.config/bash/functions/*.bash; do
      source "$f"
    done
  fi
}

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

#ensure the exports get loaded

userbashexports() {
  local d=$(ls "$HOME"/.config/bash/exports/*.bash 2>/dev/null | wc -l)
  if [ "$d" != "0" ]; then
    for f in "$HOME"/.config/bash/exports/*.bash; do
      source "$f" >/dev/null 2>&1
    done
  fi
}

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# Source additional bash scripts

userbashprofile() {
  local d=$(ls "$HOME"/.config/bash/profile/*.bash 2>/dev/null | wc -l)
  if [ "$d" != "0" ]; then
    for f in "$HOME"/.config/bash/profile/*.bash; do
      source "$f" >/dev/null 2>&1
    done
  fi
}

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# Source additional aliases scripts

userbashaliases() {
  local d=$(ls "$HOME"/.config/bash/aliases/*.bash 2>/dev/null | wc -l)
  if [ "$d" != "0" ]; then
    for f in "$HOME"/.config/bash/aliases/*.bash; do
      source "$f" >/dev/null 2>&1
    done
  fi
}

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# Source additional completion scripts

userbashcompletions() {
  local d=$(ls "$HOME"/.config/bash/completions/*.bash 2>/dev/null | wc -l)
  if [ "$d" != "0" ]; then
    for f in "$HOME"/.config/bash/completions/*.bash; do
      source "$f" >/dev/null 2>&1
    done
  fi
}


# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# Source plugins

userbashplugins() {
  local d=$(ls "$HOME"/.config/bash/plugins/*.bash 2>/dev/null | wc -l)
  if [ "$d" != "0" ]; then
    for f in "$HOME"/.config/bash/plugins/*.bash; do
      source "$f" >/dev/null 2>&1
    done
  fi
}

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# Source additional PS1 prompt scripts

userbashprompt() {
  local d=$(ls "$HOME"/.config/bash/prompt/*.bash 2>/dev/null | wc -l)
  if [ "$d" != "0" ]; then
    for f in "$HOME"/.config/bash/prompt/*.bash; do
      source "$f" >/dev/null 2>&1
    done
  fi
}

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# Source OS specific

userbashos() {
  local d=$(ls "$HOME"/.config/bash/*/*.load 2>/dev/null | wc -l)
  if [ "$d" != "0" ]; then
    for f in "$HOME"/.config/bash/*/*.load; do
      source "$f" >/dev/null 2>&1
    done
  fi
}

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# Source additional user bash scripts

userbashprofilelocal() {
  local d=$(ls "$HOME"/.config/bash/local/*.bash 2>/dev/null | wc -l)
  if [ "$d" != "0" ]; then
    for f in "$HOME"/.config/bash/local/*.bash; do
      source "$f" >/dev/null 2>&1
    done
  fi
}

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

for executeuserfunct in userbashfunctions userbashexports userbashprofile userbashaliases userbashcompletions userbashplugins \
    userbashprompt userbashos userbashprofilelocal; do
  $executeuserfunct 
done

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

#Local file
if [ -f "$HOME/.config/local/bash.local" ]; then
  source "$HOME/.config/local/bash.local"
fi

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

#Servers specific
if [ -f "$HOME/.config/local/bash.servers.local" ]; then
  source "$HOME/.config/local/bash.servers.local"
fi

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

#System specific
if [ -f "$HOME/.config/local/bash."$(hostname)".local" ]; then
  source "$HOME/.config/local/bash."$(hostname)".local"
fi

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

export SRCBASHRC="$HOME/.bashrc"
export PATH="$(echo $PATH | tr ':' '\n' | awk '!seen[$0]++' | tr '\n' ':' | sed 's#::#:.#g')"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

show_welcome

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# run neofetch
#if echo "$-" | grep i >/dev/null; then
#  if [ -n "$(command -v neofetch 2>/dev/null)" ]; then
#    neofetch
#  fi
#fi

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# Send an e-mail every time you login

#echo "ALERT - Shell Access on $HOSTNAME from $USER on: `date`" | mail -r no-reply -s "Alert: Access from $USER" $USER@$HOSTNAME

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# end
