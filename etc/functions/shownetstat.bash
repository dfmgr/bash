#!/usr/bin/env bash
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# @Author      : Jason
# @Contact     : casjaysdev@casjay.net
# @File        : shownetstat
# @Created     : Mon, Dec 31, 2019, 00:00 EST
# @License     : WTFPL
# @Copyright   : Copyright (c) CasjaysDev
# @Description : monitors the network activity
#
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
shownetstat() {
  [ -f "$(command -v grc 2>/dev/null)" ] || return
  #  watch --color -tn1 sudo grc 'netstat -tuapn4|tail -n+3|grep -v "\(systemd-resolv\|FIN_WAIT1\|FIN_WAIT2\|TIME_WAIT\\)"'
  #  watch --color -tn1 sudo grc 'netstat -tuapn|tail -n+3|grep -v "\(systemd-resolv\|cupsd\|FIN_WAIT1\|FIN_WAIT2\|TIME_WAIT\\)"'
  #  watch --color -tn1 sudo grc 'ss -tuapn4|tail -n+2|grep -v "\(systemd-resolv\|cupsd\|FIN_WAIT1\|FIN_WAIT2\|TIME_WAIT\\)"'
  #  watch --color -tn1 sudo grc 'ss -tuapn4|tail -n+2|grep -v "\(systemd-resolv\|FIN_WAIT1\|FIN_WAIT2\|TIME_WAIT\\)"'
  watch --color -tn1 sudo grc 'ss -tuapn | awk '\''{if(NR>1){if(0==match($0,/systemd-resolv|FIN-WAIT-1|FIN-WAIT-2|TIME-WAIT|LAST-ACK|SYN-SENT/)){gsub(/\s+/," ");gsub(/users\:\(\(|\)\)/,"");;print}}}'\'
}
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# end
