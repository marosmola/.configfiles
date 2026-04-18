# .configfiles

macOS window management setup: **yabai + skhd + Hammerspoon + stackline + Raycast**.

## What's included

| Package | Stow target | Contents |
|---------|-------------|----------|
| `dot-config` | `~/.config/` | yabai config, skhd keybinds |
| `hammerspoon` | `~/` | Hammerspoon init + stackline-conf.lua |
| `local-bin` | `~/` | yabai helper scripts |

## Fresh install

```bash
git clone https://github.com/marosmola/.configfiles ~/Projects/marosmola/.configfiles
cd ~/Projects/marosmola/.configfiles
bash install.sh
```

`install.sh` will:
1. Install Homebrew (if missing)
2. Install `stow`, `yabai`, `skhd`, `hammerspoon`, `jq` via brew
3. Symlink all configs to their correct locations
4. Start yabai and skhd services

After that: open Hammerspoon → Reload Config.

## Manual stow (existing install)

```bash
cd ~/Projects/marosmola/.configfiles
stow --restow --target=$HOME dot-config hammerspoon local-bin
```

## Layout

```
dot-config/
  yabai/yabairc          → ~/.config/yabai/yabairc
  skhd/skhdrc            → ~/.config/skhd/skhdrc

hammerspoon/
  .hammerspoon/init.lua           → ~/.hammerspoon/init.lua
  .hammerspoon/stackline-conf.lua → copied to ~/.hammerspoon/stackline/conf.lua

stackline/  (git submodule: AdamWagner/stackline)
  symlinked to ~/.hammerspoon/stackline by install.sh

local-bin/
  .local/bin/yabai-*     → ~/.local/bin/yabai-*
```

## Key bindings (skhd)

| Binding | Action |
|---------|--------|
| `ctrl + e` | Toggle space layout |
| `ctrl + s` | Stack focused window onto last tiled |
| `ctrl + b` | Balance BSP layout |
| `ctrl + ←/→/↑/↓` | Focus window directionally / stack nav |
| `cmd + 1–6` | Switch to space |
| `ctrl + shift + 1–6` | Move window to space |
| `ctrl + f` | Toggle float |
| `cmd + tab` | Focus most recent window |

## stackline

Stackline shows per-window indicators for yabai stacks. It is tracked as a git
submodule at `stackline/` pointing to
[AdamWagner/stackline](https://github.com/AdamWagner/stackline).

Custom config lives in `hammerspoon/.hammerspoon/stackline-conf.lua` (main
repo). `install.sh` copies it into the submodule as `conf.lua` after init.
Indicators are hidden automatically when the active space is not in stack layout.
