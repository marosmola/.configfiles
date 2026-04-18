#!/bin/bash
LAYOUT=$(yabai -m query --spaces --space 2>/dev/null | jq -r '.type')
FLOATING=$(yabai -m query --windows --window 2>/dev/null | jq -r '."is-floating"' 2>/dev/null)

case "$LAYOUT" in
  bsp)   L="bsp" ;;
  float) L="float" ;;
  stack) L="stack" ;;
  *)     L="-" ;;
esac

[ "$FLOATING" = "true" ] && W="float" || W="tiled"

sketchybar --set yabai_mode label="$L · $W"
