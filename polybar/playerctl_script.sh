#!/bin/sh

player_status=$(playerctl status 2> /dev/null)

if [ "$player_status" = "Playing" ]; then
    echo "#1 $(playerctl metadata artist) - $(playerctl metadata title)" | cut -c 1-60
elif [ "$player_status" = "Paused" ]; then
    echo "#2 $(playerctl metadata artist) - $(playerctl metadata title)" | cut -c 1-60
else
  echo ";)"
fi
