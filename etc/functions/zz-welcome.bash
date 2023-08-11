#!/usr/bin/env bash
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
##@Version       : 202103251632-git
# @Author        : Jason Hempstead
# @Contact       : jason@casjaysdev.pro
# @License       : LICENSE.md
# @ReadME        : zz-welcome.bash --help
# @Copyright     : Copyright: (c) 2021 Jason Hempstead, CasjaysDev
# @Created       : Thursday, Mar 25, 2021 17:58 EDT
# @File          : zz-welcome.bash
# @Description   :
# @TODO          :
# @Other         :
# @Resource      :
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
show_welcome() {
  if [ ! -f "$HOME/.config/bash/welcome.msg" ]; then
    printf_green "\n\n\n"
    printf_green "Welcome to your system!"
    printf_green "It would appear that it"
    printf_green "has been setup successfully."
    printf_green "The .sample files can be edited"
    printf_green "and renamed as they wont be"
    printf_green "overwritten on any updates."
    printf_green "If you configured tor you can run"
    printf_green "the command show_welcome_tor"
    printf_green "\n"
    printf_read_question "4" "$ICON_QUESTION Show this message again?" "1"
    if ! printf_answer_yes; then
      touch "$HOME/.config/bash/welcome.msg"
    fi
    clear
  fi
}
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
show_welcome_tor() {
  if [ ! -f "$HOME/.config/bash/welcome_tor.msg" ]; then
    if [ ! -f "/usr/local/etc/tor/install.sh" ]; then
      printf_info "The tor package has not been installed"
      printf_cyan "You can install it by running systemmgr install tor"
    else
      if (sudo -vn && sudo -ln) 2>&1 | grep -v 'may not' >/dev/null; then
        if sudo bash -c '[ -f /var/lib/tor/hidden_service/hostname ]'; then
          printf_green "the tor hostname of this system is:"
          printf_green "$(sudo cat /var/lib/tor/hidden_service/hostname)"
          printf_info "The hostname has been saved to $HOME/tor_hostname"
          cat /var/lib/tor/hidden_service/hostname | sudo tee "$HOME/tor_hostname" &>/dev/null
          printf_read_question "3" "$ICON_QUESTION Show this message again?" "1"
          printf "\n"
          if ! printf_answer_yes; then
            touch "$HOME/.config/bash/welcome_tor.msg"
          fi
        fi
      fi
    fi
  fi
}
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# end
