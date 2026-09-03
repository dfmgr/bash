#!/usr/bin/env bash
# shellcheck shell=bash
# - - - - - - - - - - - - - - - - - - - - - - - -
##@Version           :  202609031422-git
# @@Author           :  Jason Hempstead
# @@Contact          :  git-admin@casjaysdev.pro
# @@License          :  WTFPL
# @@ReadME           :  README.md
# @@Copyright        :  Copyright: (c) 2021 Jason Hempstead, Casjays Developments
# @@Created          :  Thursday, Mar 25, 2021 16:43 EDT
# @@File             :  getip.bash
# @@Description      :  detect and print the current LAN/WAN IPv4 and IPv6 addresses
# @@Changelog        :  standardized header to WTFPL @@-field template
# @@TODO             :
# @@Other            :
# @@Resource         :
# @@Terminal App     :  no
# @@sudo/root        :  no
# @@Template         :  shell/bash
# - - - - - - - - - - - - - - - - - - - - - - - -
# shellcheck disable=SC1001,SC1003,SC2001,SC2003,SC2016,SC2031,SC2090,SC2115,SC2120,SC2155,SC2199,SC2229,SC2317,SC2329
# - - - - - - - - - - - - - - - - - - - - - - - -
VERSION="202609031422-git"
unset IFCONFIG NETDEV IFISONLINE CURRIP4 CURRIP6 CURRIP4WAN CURRIP6WAN
if [ -f "$(builtin command -v myip 2>/dev/null)" ]; then
  alias __getip='myip'
else
  __getip() {
    IFCONFIG="$(command -v ifconfig 2>/dev/null)"
    if [ -n "$IFCONFIG" ]; then
      if [[ "$OSTYPE" =~ ^darwin ]]; then
        NETDEV="$(route get default | awk '/interface/ {print $2}')"
      else
        NETDEV="$(ip route | awk '/default/ {print $5}')"
      fi
      CURRIP4="$(ifconfig "$NETDEV" | awk '/inet / && !/127.0.0./ && !/inet6/ {gsub(/addr:/,""); print $2; exit}')"
      CURRIP6="$(ifconfig "$NETDEV" | awk '/inet6.*global/ && !/docker/ {print $2; exit}')"
      is_online && IFISONLINE=0 || IFISONLINE=1
      if [ "$IFISONLINE" = 0 ]; then
        CURRIP4WAN="$(curl -4qs --max-time 2 ifconfig.co/ip 2>/dev/null)"
        CURRIP6WAN="$(curl -6qs --max-time 2 ifconfig.co/ip 2>/dev/null)"
      fi
      [ -z "$CURRIP4" ] || echo "$CURRIP4"
      [ -z "$CURRIP6" ] || echo "$CURRIP6"
      [ -z "$CURRIP4WAN" ] || echo "$CURRIP4WAN"
      [ -z "$CURRIP6WAN" ] || echo "$CURRIP6WAN"
      unset IFCONFIG NETDEV IFISONLINE CURRIP4 CURRIP6 CURRIP4WAN CURRIP6WAN
    fi
  }
fi
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# end
