#!/usr/bin/env bash
set -euo pipefail

REPO="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# ── Homebrew ──────────────────────────────────────────────────────────────────
if ! command -v brew &>/dev/null; then
  echo "Installing Homebrew..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

# ── Dependencies ──────────────────────────────────────────────────────────────
brew_install() {
  brew list "$1" &>/dev/null || brew install "$1"
}

brew_install stow
brew_install jq

# ── Tap felixkratz for yabai, sketchybar, borders ─────────────────────────────
brew tap felixkratz/formulae 2>/dev/null || true
brew_install yabai
brew_install skhd
brew_install felixkratz/formulae/sketchybar
brew_install felixkratz/formulae/borders

if ! brew list --cask hammerspoon &>/dev/null; then
  brew install --cask hammerspoon
fi

# ── Stow packages ─────────────────────────────────────────────────────────────
stow_pkg() {
  echo "Stowing $1..."
  stow --restow --target="$HOME" --dir="$REPO" "$1"
}

# Back up any existing real files that stow would conflict with
backup_if_real() {
  local target="$1"
  if [ -e "$target" ] && [ ! -L "$target" ]; then
    echo "Backing up $target → $target.bak"
    mv "$target" "$target.bak"
  fi
}

backup_if_real "$HOME/.config/yabai/yabairc"
backup_if_real "$HOME/.config/skhd/skhdrc"
backup_if_real "$HOME/.config/sketchybar/sketchybarrc"
backup_if_real "$HOME/.config/borders/bordersrc"
backup_if_real "$HOME/.config/ghostty/config"
backup_if_real "$HOME/.hammerspoon/init.lua"
backup_if_real "$HOME/.hammerspoon/stackline"

mkdir -p "$HOME/.config/yabai" "$HOME/.config/skhd" "$HOME/.config/sketchybar/plugins" "$HOME/.config/borders" "$HOME/.config/ghostty" "$HOME/.local/bin"

stow_pkg dot-config
stow_pkg hammerspoon
stow_pkg local-bin

chmod +x "$HOME/.local/bin/yabai-stack-last"
chmod +x "$HOME/.local/bin/yabai-record-last-tiled"
chmod +x "$HOME/.local/bin/yabai-cycle-layout"
chmod +x "$HOME/.config/sketchybar/plugins/space.sh"
chmod +x "$HOME/.config/sketchybar/plugins/yabai_mode.sh"
chmod +x "$HOME/.config/sketchybar/sketchybarrc"
chmod +x "$HOME/.config/borders/bordersrc"

# ── Stackline (submodule) ─────────────────────────────────────────────────────
echo "Setting up stackline..."
git -C "$REPO" submodule update --init --recursive
ln -sf "$REPO/stackline" "$HOME/.hammerspoon/stackline"
cp "$REPO/hammerspoon/.hammerspoon/stackline-conf.lua" "$HOME/.hammerspoon/stackline/conf.lua"

# ── Start services ────────────────────────────────────────────────────────────
echo "Starting services..."
yabai --start-service 2>/dev/null || true
skhd --start-service 2>/dev/null || true
brew services start felixkratz/formulae/sketchybar 2>/dev/null || true
brew services start felixkratz/formulae/borders 2>/dev/null || true

echo ""
echo "Done. Open Hammerspoon and click 'Reload Config'."
echo "Grant Accessibility permissions to: yabai, skhd, borders, Hammerspoon."
