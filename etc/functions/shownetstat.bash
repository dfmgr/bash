#!/usr/bin/env bash
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
##@Version       : 202103251632-git
# @Author        : Jason Hempstead
# @Contact       : jason@casjaysdev.pro
# @License       : LICENSE.md
# @ReadME        : shownetstat.bash --help
# @Copyright     : Copyright: (c) 2021 Jason Hempstead, CasjaysDev
# @Created       : Thursday, Mar 25, 2021 16:49 EDT
# @File          : shownetstat.bash
# @Description   :
# @TODO          :
# @Other         :
# @Resource      :
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
shownetstat() {
  [ -f "$(builtin command -v grc 2>/dev/null)" ] || return
  #  watch --color -tn1 sudo grc 'netstat -tuapn4|tail -n+3|grep -v "\(systemd-resolv\|FIN_WAIT1\|FIN_WAIT2\|TIME_WAIT\\)"'
  #  watch --color -tn1 sudo grc 'netstat -tuapn|tail -n+3|grep -v "\(systemd-resolv\|cupsd\|FIN_WAIT1\|FIN_WAIT2\|TIME_WAIT\\)"'
  #  watch --color -tn1 sudo grc 'ss -tuapn4|tail -n+2|grep -v "\(systemd-resolv\|cupsd\|FIN_WAIT1\|FIN_WAIT2\|TIME_WAIT\\)"'
  #  watch --color -tn1 sudo grc 'ss -tuapn4|tail -n+2|grep -v "\(systemd-resolv\|FIN_WAIT1\|FIN_WAIT2\|TIME_WAIT\\)"'
  watch --color -tn1 sudo grc 'ss -tuapn | awk '\''{if(NR>1){if(0==match($0,/systemd-resolv|FIN-WAIT-1|FIN-WAIT-2|TIME-WAIT|LAST-ACK|SYN-SENT/)){gsub(/\s+/," ");gsub(/users\:\(\(|\)\)/,"");;print}}}'\'
}
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# end
