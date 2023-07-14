#!/bin/sh

updates_status=$(checkupdates 2>/dev/null | wc -l)

if [ "$updates_status" = "==> ERROR: Cannot fetch updates" ]; then
    echo "🫗"
else
  echo "$updates_status"
fi

