# nvim config

A minimal, handcrafted Neovim 0.12 configuration built from scratch — no distros, no bloat, every line understood.

## Requirements

- Neovim 0.12+
- [Ghostty](https://ghostty.org) (recommended terminal)
- [Maple Mono](https://github.com/subframe7536/maple-font) (recommended font)
- Node.js & npm
- Rust & Cargo (for tree-sitter CLI)
- Java (OpenJDK 23+)
- Homebrew (macOS)

## Plugins

| Plugin | Purpose |
|---|---|
| [fzf-lua](https://github.com/ibhagwan/fzf-lua) | Fuzzy finder for files, grep, LSP symbols |
| [nvim-lspconfig](https://github.com/neovim/nvim-lspconfig) | LSP configuration |
| [blink.cmp](https://github.com/saghen/blink.cmp) | Autocompletion |
| [nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter) | Syntax highlighting |
| [conform.nvim](https://github.com/stevearc/conform.nvim) | Formatting |
| [gitsigns.nvim](https://github.com/lewis6991/gitsigns.nvim) | Git integration |
| [toggleterm.nvim](https://github.com/akinsho/toggleterm.nvim) | Terminal management |
| [oil.nvim](https://github.com/stevearc/oil.nvim) | File explorer |
| [bufferline.nvim](https://github.com/akinsho/bufferline.nvim) | Buffer tabs |
| [mini.statusline](https://github.com/echasnovski/mini.statusline) | Statusline |
| [mini.pairs](https://github.com/echasnovski/mini.pairs) | Auto pairs |
| [mini.surround](https://github.com/echasnovski/mini.surround) | Surround motions |
| [mini.icons](https://github.com/echasnovski/mini.icons) | Icons |
| [which-key.nvim](https://github.com/folke/which-key.nvim) | Keymap hints |
| [todo-comments.nvim](https://github.com/folke/todo-comments.nvim) | TODO highlights |
| [neoscroll.nvim](https://github.com/karb94/neoscroll.nvim) | Smooth scrolling |
| [alpha-nvim](https://github.com/goolord/alpha-nvim) | Dashboard |
| [kanagawa.nvim](https://github.com/rebelot/kanagawa.nvim) | Default colorscheme |
| [tokyonight.nvim](https://github.com/folke/tokyonight.nvim) | Colorscheme |
| [rose-pine](https://github.com/rose-pine/neovim) | Colorscheme |
| [poimandres.nvim](https://github.com/olivercederborg/poimandres.nvim) | Colorscheme |
| [nvim-jdtls](https://github.com/mfussenegger/nvim-jdtls) | Java LSP |

## LSP Servers

- `ts_ls` — TypeScript / JavaScript
- `svelte` — Svelte
- `cssls` — CSS / SCSS
- `tailwindcss` — Tailwind CSS
- `emmet_language_server` — Emmet
- `lua_ls` — Lua
- `jdtls` — Java

Install them:

```bash
npm install -g typescript-language-server svelte-language-server \
  vscode-langservers-extracted @tailwindcss/language-server \
  @olrtg/emmet-language-server

brew install lua-language-server jdtls
```

## Key Mappings

`<leader>` is `Space`.

### General

| Key | Action |
|---|---|
| `jk` | Exit insert mode |
| `<leader>d` | Show diagnostics |
| `<C-h/j/k/l>` | Move between windows |
| `<Tab>` | Next buffer |
| `<S-Tab>` | Previous buffer |
| `<leader>x` | Close buffer |
| `<leader>th` | Theme picker |

### Files & Search

| Key | Action |
|---|---|
| `<leader><leader>` | Find files |
| `<leader>/` | Live grep |
| `<leader>fs` | LSP document symbols |
| `<leader>ft` | Find TODOs |
| `-` | Open file explorer (oil.nvim) |

### LSP

| Key | Action |
|---|---|
| `gd` | Go to definition |
| `gr` | Go to references |
| `gI` | Go to implementation |
| `gy` | Go to type definition |
| `K` | Hover documentation |
| `<leader>rn` | Rename symbol |
| `<leader>ca` | Code action |
| `<leader>f` | Format buffer |

### Git

| Key | Action |
|---|---|
| `<leader>gp` | Preview hunk |
| `<leader>gb` | Blame line |
| `<leader>gs` | Stage hunk |
| `<leader>gr` | Reset hunk |
| `]h` / `[h` | Next / prev hunk |

### Terminal

| Key | Action |
|---|---|
| `opt+h` | Horizontal terminal |
| `opt+v` | Vertical terminal |
| `opt+t` | Floating terminal |

### Java

| Key | Action |
|---|---|
| `<leader>oi` | Organize imports |
| `<leader>tt` | Run current test class |

### Splits

| Key | Action |
|---|---|
| `<leader>sv` | Vertical split and focus |
| `<leader>sh` | Horizontal split and focus |

## Structure

```
~/.config/nvim/
├── init.lua          # Main config
├── ftplugin/
│   └── java.lua      # Java specific config
├── lsp/
│   ├── ts_ls.lua
│   ├── svelte.lua
│   ├── cssls.lua
│   ├── tailwindcss.lua
│   ├── emmet_language_server.lua
│   └── lua_ls.lua
├── queries/
│   └── svelte/       # Custom treesitter queries
│       └── injections.scm
└── parser/           # Manually compiled parsers
```

## Notes

- Svelte treesitter parser is manually compiled — see `queries/svelte/injections.scm` for the injection fix required for embedded TypeScript highlighting.
- Java LSP requires [lombok](https://projectlombok.org) at `~/.local/share/lombok/lombok.jar`.
- Ghostty config lives at `~/.config/ghostty/config` with `macos-option-as-alt = true` for terminal keymaps to work.
