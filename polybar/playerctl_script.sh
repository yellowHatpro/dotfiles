#!/bin/sh

player_status=$(playerctl status 2> /dev/null)

if [ "$player_status" = "Playing" ]; then
    echo " $(playerctl metadata title) - $(playerctl metadata artist)" | cut -c 1-30
elif [ "$player_status" = "Paused" ]; then
    echo " $(playerctl metadata title) - $(playerctl metadata artist)" | cut -c 1-30
else
  echo ""
fi
