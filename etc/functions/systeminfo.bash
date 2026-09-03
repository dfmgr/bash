#!/usr/bin/env bash
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
##@Version       : 202103251632-git
# @Author        : Jason Hempstead
# @Contact       : jason@casjaysdev.pro
# @License       : LICENSE.md
# @ReadME        : systeminfo.bash --help
# @Copyright     : Copyright: (c) 2021 Jason Hempstead, CasjaysDev
# @Created       : Thursday, Mar 25, 2021 17:56 EDT
# @File          : systeminfo.bash
# @Description   : Show system information
# @TODO          :
# @Other         :
# @Resource      :
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
showcputemp() {
  [ -r /sys/class/thermal/thermal_zone0/temp ] || {
    echo "Error: thermal zone not available" >&2
    return 1
  }
  awk -v t="$(cat /sys/class/thermal/thermal_zone0/temp)" 'BEGIN{print t/1000}'
}
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
showsysteminfo() {
  if [ "$1" = "--help" ] || [ "$1" = "-h" ]; then
    echo "Usage: showsysteminfo"
    echo "Show CPU, memory, OS, kernel, uptime, users, and disk info (Linux only)"
    return 0
  fi
  if [ ! -f /proc/cpuinfo ]; then
    echo "Error: showsysteminfo is Linux only" >&2
    return 1
  fi
  echo ""
  echo -e "${LIGHTRED}   CPU:$NC"
  sed -nr 's/model name[^:*]: (.*)/\t\1/p' /proc/cpuinfo
  echo -ne "${LIGHTRED}MEMORY:$NC\t"
  awk '/MemTotal/{mt=$2};/MemFree/{mf=$2};/MemAvail/{ma=$2}END{print "Total: "mt" | Free: "mf" | Available: "ma" (kB)"}' /proc/meminfo
  echo -ne "${LIGHTRED}    OS:$NC\t"
  lsb_release -cds | awk '{printf("%s ", $0)}'
  echo
  echo -ne "${LIGHTRED}KERNEL:$NC\t"
  uname -a | awk '{ print $3 }'
  echo -ne "${LIGHTRED}  ARCH:$NC\t"
  uname -m
  echo -ne "${LIGHTRED}UPTIME:$NC\t"
  uptime -p
  echo -ne "${LIGHTRED} USERS:$NC\t"
  w -h | awk '{u[$1]=1} END{for (n in u) printf "%s ", n; print ""}'
  echo -ne "${LIGHTRED}  DISK:$NC"
  df -h | grep -E -e "/dev/(sd|nvme|vd|xvd)" -e "/mnt/" | awk '{print "\t"$0}'
  echo ""
}
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
showkernelgraph() {
  lsmod | perl -e 'print "digraph \"lsmod\" {";
                 <>;
                 while(<>){
                   @_=split/\s+/;
                   print "\"$_[0]\" -> \"$_\"\n" for split/,/,$_[3]
                 }
                 print "}"' | dot -Tsvg | rsvg-view-3 /dev/stdin
}
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# end
