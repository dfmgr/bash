#!/usr/bin/env bash

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# @Author      : Jason
# @Contact     : casjaysdev@casjay.net
# @File        : zz-welcome.bash
# @Created     : Mon, Dec 23, 2019, 14:13 EST
# @License     : WTFPL
# @Copyright   : Copyright (c) CasjaysDev
# @Description : welcome message
#
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

show_welcome() {
  if [ ! -f $HOME/.config/bash/welcome.msg ]; then
    printf_green "Welcome to your system!"
    printf_green "It would appear that it"
    printf_green "has been setup successfully."
    printf_green "The .sample files can be edited"
    printf_green "and renamed as they wont be"
    printf_green "overwritten on any updates."
    printf_green "If you configured tor you can run"
    printf_green "the command show_welcome_tor"
    printf_green "\n"
    ask_for_confirmation "Show this message again?"
    printf "\n"
    if ! answer_is_yes; then
      touch $HOME/.config/bash/welcome.msg
    fi
  fi
}

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

show_welcome_tor() {
  if [ ! -f $HOME/.config/bash/welcome_tor.msg ]; then
    if [ ! -f /usr/local/etc/tor/install.sh ]; then
      printf_info "The tor package has not been installed"
      printf_green "You can install it by running dotfiles install tor"
    else
      if (sudo -vn && sudo -ln) 2>&1 | grep -v 'may not' >/dev/null; then
        if sudo bash -c '[ -f /var/lib/tor/hidden_service/hostname ]'; then
          printf_green "the tor hostname of this system is:"
          printf_green "$(sudo cat /var/lib/tor/hidden_service/hostname)"
          printf_info "The hostname has been saved to $HOME/tor_hostname"
          sudo cat /var/lib/tor/hidden_service/hostname >"$HOME/tor_hostname"
          ask_for_confirmation "Show this message again?"
          printf "\n"
          if ! answer_is_yes; then
            touch $HOME/.config/bash/welcome_tor.msg
          fi
        fi
      fi
    fi
  fi
}

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
