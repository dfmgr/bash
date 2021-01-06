#!/usr/bin/env bash

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# @Author      : Jason
# @Contact     : casjaysdev@casjay.net
# @File        : getip.bash
# @Created     : Mon, Dec 31, 2019, 00:00 EST
# @License     : WTFPL
# @Copyright   : Copyright (c) CasjaysDev
# @Description : get ip address
#
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

unset IFCONFIG NETDEV IFISONLINE CURRIP4 CURRIP6 CURRIP4WAN CURRIP6WAN

if cmd_exists myip; then
  alias __getip="myip"
else
__getip() {
  IFCONFIG="$(sudo bash -c "command -v ifconfig 2>/dev/null")"
  if [ ! -z "$IFCONFIG" ]; then
    if [[ "$OSTYPE" =~ ^darwin ]]; then
      NETDEV="$(route get default | grep interface | awk '{print $2}')"
    else
      NETDEV="$(ip route | grep default | sed -e "s/^.*dev.//" -e "s/.proto.*//")"
    fi
    CURRIP4="$(sudo ifconfig $NETDEV | grep -E 'venet|inet' | grep -v '127.0.0.' | grep inet | grep -v 'inet6' | awk '{print $2}' | sed 's#addr:##g' | head -n1)"
    CURRIP6="$(sudo ifconfig $NETDEV | grep -E 'venet|inet' | grep -v 'docker' | grep inet6 | grep -i 'global' | awk '{print $2}' | head -n1)"
    IFISONLINE="$(
      timeout 0.3 ping -c1 8.8.8.8 &>/dev/null
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

#---------------------------------------------------------------------------------------
