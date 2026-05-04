# vimPack

Personal Neovim configuration for Neovim 0.12+.

The repository is laid out as an XDG config tree and is intended to be installed with GNU Stow.

## Install

From the repository root:

```sh
stow -S --no-folding -t $HOME .
```

This links `.config/nvim` into `XDG_CONFIG_HOME`, usually `~/.config/nvim`.

Plugins are managed with Neovim's built-in `vim.pack`. The pack lock file lives under the Neovim config directory, so it is kept at:

```text
.config/nvim/nvim-pack-lock.json
```

## Test Locally

To run this config in an isolated environment from the repository root:

```sh
mkdir -p .test-xdg/{data,state,cache,runtime}
chmod 700 .test-xdg/runtime

XDG_CONFIG_HOME="$PWD/.config" \
XDG_DATA_HOME="$PWD/.test-xdg/data" \
XDG_STATE_HOME="$PWD/.test-xdg/state" \
XDG_CACHE_HOME="$PWD/.test-xdg/cache" \
XDG_RUNTIME_DIR="$PWD/.test-xdg/runtime" \
nvim
```

This keeps test plugins, logs, shada, and cache files under `.test-xdg/`.

System clipboard integration is enabled by default for local sessions and skipped automatically in SSH sessions.

## Keyboard Layout

This configuration assumes a Workman keyboard layout. Several core navigation and editing keys are remapped in:

```text
.config/nvim/lua/config/keymaps.lua
```

The main movement layer maps `y/n/e/o` to left/down/up/right. Related window movement, search navigation, yank, and line insertion mappings are also adjusted around that layout.

## Checks

Useful quick checks:

```sh
luac -p .config/nvim/init.lua .config/nvim/lua/config/*.lua .config/nvim/lsp/*.lua
stylua --check .config/nvim
```
