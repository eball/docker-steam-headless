#!/usr/bin/env bash
###
# File: start-desktop.sh
# Project: bin
# File Created: Thursday, 1st January 1970 12:00:00 pm
# Author: Josh.5 (jsunnex@gmail.com)
# -----
# Last Modified: Sunday, 2nd October 2022 22:58:17 pm
# Modified By: Josh.5 (jsunnex@gmail.com)
###
set -e

# CATCH TERM SIGNAL:
_term() {
    kill -TERM "$pulseaudio_pid" 2>/dev/null
}
trap _term SIGTERM SIGINT


# EXECUTE PROCESS:
echo "PULSEAUDIO: Starting pulseaudio service"
#/usr/bin/pulseaudio --disallow-module-loading --disallow-exit --exit-idle-time=-1 &
/usr/bin/pulseaudio --exit-idle-time=-1 &
pulseaudio_pid=$!


wait_for_pulse() {
    MAX=60 # About 30 seconds
    CT=0
    while ! pactl stat >/dev/null 2>&1; do
        sleep 0.50s
        CT=$(( CT + 1 ))
        if [ "$CT" -ge "$MAX" ]; then
            echo "FATAL: $0: Gave up waiting for pulse audio"
            kill -TERM "$pulseaudio_pid" 2>/dev/null
            exit 11
        fi
    done
}

if [[ "${DEVICE_NAME}" = "Olares One" ]]; then
    echo "PULSEAUDIO: Setting Olares One HDMI audio output"
    wait_for_pulse
    # Set HDMI audio output
    pactl load-module module-alsa-sink device=plughw:0,3 sink_name=nvhdmi || { kill -TERM "$pulseaudio_pid" 2>/dev/null && exit 12; }
    amixer -c 0 sset 'IEC958' on
    pactl unload-module module-alsa-sink
fi

# WAIT FOR CHILD PROCESS:
wait "$pulseaudio_pid"
