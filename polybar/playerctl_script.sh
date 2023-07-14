#!/bin/sh

player_status=$(playerctl status 2> /dev/null)

if [ "$player_status" = "Playing" ]; then
    echo " $(playerctl metadata artist) - $(playerctl metadata title)" | cut -c 1-60
elif [ "$player_status" = "Paused" ]; then
    echo " $(playerctl metadata artist) - $(playerctl metadata title)" | cut -c 1-60
else
  echo ""
fi
