#!/usr/bin/env bash
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
##@Version       : 202103251632-git
# @Author        : Jason Hempstead
# @Contact       : jason@casjaysdev.pro
# @License       : LICENSE.md
# @ReadME        : getip.bash --help
# @Copyright     : Copyright: (c) 2021 Jason Hempstead, CasjaysDev
# @Created       : Thursday, Mar 25, 2021 16:43 EDT
# @File          : getip.bash
# @Description   :
# @TODO          :
# @Other         :
# @Resource      :
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
unset IFCONFIG NETDEV IFISONLINE CURRIP4 CURRIP6 CURRIP4WAN CURRIP6WAN
if [ -f "$(builtin command -v myip 2>/dev/null)" ]; then
  alias __getip='myip'
else
  __getip() {
    IFCONFIG="$(sudo bash -c "command -v ifconfig 2>/dev/null")"
    if [ -n "$IFCONFIG" ]; then
      if [[ "$OSTYPE" =~ ^darwin ]]; then
        NETDEV="$(route get default | grep interface | awk '{print $2}')"
      else
        NETDEV="$(ip route | grep default | sed -e "s/^.*dev.//" -e "s/.proto.*//")"
      fi
      CURRIP4="$(sudo ifconfig $NETDEV | grep -E 'venet|inet' | grep -v '127.0.0.' | grep inet | grep -v 'inet6' | awk '{print $2}' | sed 's#addr:##g' | head -n1)"
      CURRIP6="$(sudo ifconfig $NETDEV | grep -E 'venet|inet' | grep -v 'docker' | grep inet6 | grep -i 'global' | awk '{print $2}' | head -n1)"
      IFISONLINE="$(
        is_online
        echo $?
      )"
      if [ "$IFISONLINE" = 0 ]; then
        CURRIP4WAN="$(
          curl -I4qs ifconfig.co/ip 2>/dev/null | head -1 | grep 404 >/dev/null
          if [ "$?" = 0 ]; then curl -4qs ifconfig.co/ip 2>/dev/null; fi
        )"
        CURRIP6WAN="$(
          curl -I6qs ifconfig.co/ip 2>/dev/null | head -1 | grep 404 >/dev/null
          if [ "$?" = 0 ]; then curl -6qs ifconfig.co/ip 2>/dev/null; fi
        )"
      fi
      [ -z "$CURRIP4" ] || echo $CURRIP4
      [ -z "$CURRIP6" ] || echo $CURRIP6
      [ -z "$CURRIP4WAN" ] || echo $CURRIP4WAN
      [ -z "$CURRIP6WAN" ] || echo $CURRIP6WAN
      unset IFCONFIG NETDEV IFISONLINE CURRIP4 CURRIP6 CURRIP4WAN CURRIP6WAN
    fi
  }
fi
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# end
