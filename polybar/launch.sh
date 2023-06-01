#!/bin/bash
# Terminate already running bar instances
killall -q polybar
# Launch the bar
echo "---" | tee -a /tmp/polybar1.log /tmp/polybar2.log
polybar example >>/tmp/polybar1.log 2>&1 &

echo "Bar launched.."
