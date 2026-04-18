# .configfiles

macOS window management setup: **yabai + skhd + Hammerspoon + stackline + sketchybar + JankyBorders + Ghostty**.

## What's included

| Package | Stow target | Contents |
|---------|-------------|----------|
| `dot-config` | `~/.config/` | yabai, skhd, sketchybar, borders, ghostty configs |
| `hammerspoon` | `~/` | Hammerspoon init + stackline-conf.lua |
| `local-bin` | `~/` | yabai helper scripts |

## Dependencies

All installed automatically by `install.sh`.

| Tool | Source | Purpose |
|------|--------|---------|
| `yabai` | `felixkratz/formulae` | Tiling window manager |
| `skhd` | homebrew | Hotkey daemon |
| `sketchybar` | `felixkratz/formulae` | Status bar (spaces, layout info) |
| `borders` | `felixkratz/formulae` | Window focus borders (JankyBorders) |
| `hammerspoon` | homebrew cask | Lua automation |
| `stackline` | git submodule | Stack indicators for yabai stacks |
| `jq` | homebrew | JSON parsing for helper scripts |
| `stow` | homebrew | Symlink management |
| Ghostty | manual install | Terminal emulator |

> **Note:** Ghostty must be installed manually from [ghostty.org](https://ghostty.org) — it is not available via homebrew.

## Fresh install

```bash
git clone --recurse-submodules https://github.com/marosmola/.configfiles ~/Projects/marosmola/.configfiles
cd ~/Projects/marosmola/.configfiles
bash install.sh
```

`install.sh` will:
1. Install Homebrew (if missing)
2. Tap `felixkratz/formulae` and install all dependencies
3. Symlink all configs to their correct locations
4. Start yabai, skhd, sketchybar, and borders services

After that:
- Open Hammerspoon → Reload Config
- Grant **Accessibility** permissions to: `yabai`, `skhd`, `borders`, `Hammerspoon`

## Manual stow (existing install)

```bash
cd ~/Projects/marosmola/.configfiles
stow --restow --target=$HOME dot-config hammerspoon local-bin
```

## Layout

```
dot-config/
  .config/yabai/yabairc              → ~/.config/yabai/yabairc
  .config/skhd/skhdrc                → ~/.config/skhd/skhdrc
  .config/sketchybar/sketchybarrc    → ~/.config/sketchybar/sketchybarrc
  .config/sketchybar/plugins/        → ~/.config/sketchybar/plugins/
  .config/borders/bordersrc          → ~/.config/borders/bordersrc
  .config/ghostty/config             → ~/.config/ghostty/config

hammerspoon/
  .hammerspoon/init.lua              → ~/.hammerspoon/init.lua
  .hammerspoon/stackline-conf.lua    → copied to ~/.hammerspoon/stackline/conf.lua

stackline/  (git submodule: AdamWagner/stackline)
  symlinked to ~/.hammerspoon/stackline by install.sh

local-bin/
  .local/bin/yabai-*                 → ~/.local/bin/yabai-*
```

## Key bindings (skhd)

| Binding | Action |
|---------|--------|
| `ctrl + e` | Toggle space layout (bsp/float) |
| `ctrl + s` | Stack focused window onto last tiled |
| `ctrl + b` | Balance BSP layout |
| `ctrl + f` | Toggle float |
| `ctrl + t` | Toggle split direction |
| `ctrl + ←/→/↑/↓` | Focus window directionally / stack nav |
| `ctrl + shift + ←/→/↑/↓` | Move window directionally (warp) |
| `cmd + 1–6` | Switch to space |
| `ctrl + shift + 1–6` | Move window to space |
| `cmd + enter` | Open new Ghostty window |
| `cmd + tab` | Focus most recent window |
| `ctrl + shift + r` | Reload yabai config |

## stackline

Stackline shows per-window indicators for yabai stacks. Tracked as a git submodule at `stackline/` pointing to [AdamWagner/stackline](https://github.com/AdamWagner/stackline). Custom config in `hammerspoon/.hammerspoon/stackline-conf.lua`.
