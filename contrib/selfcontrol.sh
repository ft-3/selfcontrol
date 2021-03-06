#!/bin/sh
### BEGIN INIT INFO
# Provides:          iptables
# Required-Start:    mountkernfs $local_fs
# Required-Stop:     $local_fs
# Default-Start:     2 3 4 5
# Default-Stop:      0 1 6
# Short-Description: save and restore iptables rules on shutdown/restart
### END INIT INFO

# $Date$
# $HeadURL$
# $Author$
# $Revision$

#
# can't believe ubuntu didn't have one of these by default. :(
#

# unwise to change these!
SC_ETC=/etc/selfcontrol
IPT_FILE=iptables.save

PATH=/sbin:/bin

start() {
  if [ -f $SC_ETC/$IPT_FILE ]; then
    iptables-restore <$SC_ETC/$IPT_FILE
  else
   stop
  fi
}

stop() {
  [ -d $SC_ETC ] || mkdir $SC_ETC
  iptables-save >$SC_ETC/$IPT_FILE
}

case "$1" in
start)
  start
    ;;
stop)
  stop
    ;;
restart)
  stop
  start
    ;;
status)
    iptables --list SelfControl >/dev/null 2>&1 && ret=0 || ret=1
    if [ $ret -eq 0 ]; then
        echo installed
    else
        echo not installed
    fi
    exit $ret
    ;;
force-reload)
    ;;
*)
    echo "Usage: $0 {start|stop|restart|status|force-reload}" >&2
    exit 1
    ;;
esac

exit 0
