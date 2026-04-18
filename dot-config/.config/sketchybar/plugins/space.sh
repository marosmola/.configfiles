#!/bin/bash
CURRENT=$(yabai -m query --spaces --space 2>/dev/null | jq '.index')
for i in $(seq 1 6); do
  if [ "$i" = "$CURRENT" ]; then
    sketchybar --set "space.$i" label.color=0xffffffff
  else
    sketchybar --set "space.$i" label.color=0xff555555
  fi
done
