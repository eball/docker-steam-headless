#!/usr/bin/env bash
###
# File: start-udev.sh
# Project: bin
# File Created: Tuesday, 12th January 2022 8:46:47 am
# Author: Josh.5 (jsunnex@gmail.com)
# -----
# Last Modified: Friday, 14th January 2022 9:21:00 am
# Modified By: Josh.5 (jsunnex@gmail.com)
###
set -e

# CATCH TERM SIGNAL:
_term() {
    kill -TERM "$monitor_pid" 2>/dev/null
}
trap _term SIGTERM SIGINT

# EXECUTE PROCESS:
# Start udev
if command -v udevd &>/dev/null; then
    unshare --net udevd --daemon &>/dev/null
else
    /lib/systemd/systemd-udevd --daemon 
fi
# Monitor kernel uevents
udevadm monitor &
monitor_pid=$!
# Wait for 5 seconds, then request device events from the kernel
sleep 5
udevadm trigger

# WAIT FOR CHILD PROCESS:
wait "$monitor_pid"
