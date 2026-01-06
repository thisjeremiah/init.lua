# CLAUDE.md

This file provides guidance to LLMs when working with code in this repository.

## Repository Overview

This is a modular Neovim configuration using Lua and the lazy.nvim plugin manager.

The configuration follows modern Neovim best practices with a highly organized structure where each plugin and feature is isolated in its own file.

## Commands

### Managing Neovim Configuration

```bash
# Open Neovim to test configuration changes
nvim

# Check Neovim health and plugin status
nvim -c ":checkhealth"

# Update plugins using lazy.nvim (inside Neovim)
:Lazy update

# Sync plugins (update and clean unused)
:Lazy sync

# View plugin load times
:Lazy profile

# Reload a module during development (inside Neovim)
:lua R("personal.lazy.lsp")  # R() function defined in personal/init.lua

# View/edit lazy lockfile
nvim lazy-lock.json
```

### LSP and Language Server Management

```bash
# Inside Neovim - Mason commands
:Mason                  # Open Mason UI
:MasonUpdate           # Update Mason registry
:MasonInstall gopls    # Install specific language server
:MasonUninstall rust_analyzer  # Remove language server

# Format current buffer
:lua vim.lsp.buf.format()  # Or use <leader>f keybinding
```

### Testing and Debugging (Go-focused)

```bash
# Run tests (inside Neovim with cursor on test)
<leader>tr  # Run nearest test
<leader>td  # Debug nearest test
<leader>ta  # Run all tests in file

# Debug commands (DAP)
<F8>   # Continue
<F10>  # Step over
<F11>  # Step into
<F12>  # Step out
<leader>bp  # Toggle breakpoint
<leader>bc  # Set conditional breakpoint
```

## Architecture

### Module Organization

The configuration uses a namespace-based module system:

```
~/.config/nvim/
├── init.lua                  # Single line: require("personal")
└── lua/personal/
    ├── init.lua             # Core loader (loads all modules in order)
    ├── set.lua              # Vim options (tabs, UI, behavior)
    ├── remap.lua            # Keybindings and leader mappings
    ├── autocmds.lua         # Autocommands (filetypes, events)
    ├── lazy_init.lua        # Lazy.nvim bootstrap and setup
    └── lazy/                # Plugin configurations (one per file)
        ├── lsp.lua          # LSP, Mason, completion setup
        ├── telescope.lua    # Fuzzy finder configuration
        ├── colors.lua       # Colorscheme with Tinty integration
        └── [24 more...]     # Each plugin in its own file
```

### Plugin Management Pattern

Each plugin configuration in `lua/personal/lazy/` returns a table following lazy.nvim's spec format.

Lazy.nvim automatically discovers and loads these files.

Example plugin structure:

```lua
return {
  {
    "org/plugin-name",
    dependencies = { "dep/plugin" },
    event = "BufEnter",           -- Lazy load trigger
    config = function()
      -- Plugin setup code
    end,
  }
}
```

### Key Architectural Decisions

1. **Single-line init.lua**: Delegates everything to the personal module
2. **Per-plugin isolation**: Each plugin config in its own file under lazy/
3. **Lazy loading**: Most plugins load on-demand for fast startup
4. **Mason integration**: Auto-installs LSP servers, formatters, and debuggers
5. **Tinty integration**: Syncs colorscheme with system theme manager

### LSP and Completion Stack

- **LSP Management**: Mason + mason-lspconfig
- **Completion**: nvim-cmp with sources prioritized as: Copilot → LSP → Snippets → Buffer
- **Formatting**: Conform.nvim with per-filetype formatters
- **Installed Servers**: lua_ls, rust_analyzer, gopls, tailwindcss, zls
- **Custom Handlers**: Special configs for lua_ls (workspace), tailwindcss (filetypes), zls (inlay hints)

### Git Integration

- **Fugitive**: Full Git command interface (`:Git` commands)
- **Gitsigns**: Inline git hunks, blame, and staging
- **Telescope**: Git file search with `<C-p>`

### Testing and Debugging

- **Test Runner**: Neotest with go adapter
- **Debugger**: nvim-dap with delve for Go
- **DAP UI**: Custom window layout system for debug interface
- **Keybindings**: F-keys for debug control, <leader>t\* for tests

### Important Custom Functions

- `R(name)`: Module reloader for development (uses plenary)
- `get_tinty_theme()`: Fetches current theme from Tinty
- `toggle_layout()`: Switches between horizontal/vertical splits

### File Type Customizations

- `.templ` files registered as templ filetype (Go templates)
- `.env` files treated as conf filetype
- SCSS files include `@-@` in iskeyword
- HTML files skip Treesitter (use regex highlighting instead)

