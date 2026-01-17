return {
  "nvim-telescope/telescope.nvim",

  tag = "0.1.5",

  dependencies = {
    "nvim-lua/plenary.nvim"
  },

  config = function()
    require('telescope').setup({
      defaults = {
        vimgrep_arguments = {
          'rg',
          '--color=never',
          '--no-heading',
          '--with-filename',
          '--line-number',
          '--column',
          '--smart-case',
          -- Add --hidden to search hidden files (but still respect .gitignore)
          '--hidden',
        },
      },
      pickers = {
        live_grep = {
          -- Remove the empty additional_args to avoid any issues
        },
      },
    })

    local builtin = require('telescope.builtin')

    -- Old config FZF-style keymaps (prioritized)
    -- Make <leader>a use literal search by default (no regex, handles $, #{}, etc.)
    vim.keymap.set('n', '<leader>a', function()
      -- Build custom vimgrep arguments with fixed-strings flag
      local vimgrep_arguments = {
        'rg',
        '--color=never',
        '--no-heading',
        '--with-filename',
        '--line-number',
        '--column',
        '--smart-case',
        '--hidden',
        '--fixed-strings', -- Add fixed strings for literal search
      }
      builtin.live_grep({
        vimgrep_arguments = vimgrep_arguments,
        prompt_title = "Grep",
      })
    end, { desc = "Search in files (Literal)" })
    vim.keymap.set('n', '<leader>b', function()
      builtin.buffers({
        sort_mru = true,
        sort_lastused = true,
        ignore_current_buffer = true
      })
    end, { desc = "List buffers (MRU)" })
    vim.keymap.set('n', '<leader>o', builtin.find_files, { desc = "Find files" })

    -- Create :Ag command for old workflow (now literal by default)
    vim.api.nvim_create_user_command('Ag', function(opts)
      local vimgrep_arguments = {
        'rg',
        '--color=never',
        '--no-heading',
        '--with-filename',
        '--line-number',
        '--column',
        '--smart-case',
        '--hidden',
        '--fixed-strings',
      }
      builtin.live_grep({
        default_text = opts.args,
        vimgrep_arguments = vimgrep_arguments,
      })
    end, { nargs = '*', desc = "Live grep with literal strings (no regex)" })

    -- Create :AgRegex command for when you actually want regex
    vim.api.nvim_create_user_command('AgRegex', function(opts)
      builtin.live_grep({ default_text = opts.args })
    end, { nargs = '*', desc = "Live grep with regex patterns" })


    -- New config keymaps
    vim.keymap.set('n', '<leader>pf', builtin.find_files, {})
    vim.keymap.set('n', '<C-p>', builtin.git_files, {})
    vim.keymap.set('n', '<leader>pws', function()
      local word = vim.fn.expand("<cword>")
      builtin.grep_string({ search = word })
    end)
    vim.keymap.set('n', '<leader>pWs', function()
      local word = vim.fn.expand("<cWORD>")
      builtin.grep_string({ search = word })
    end)
    vim.keymap.set('n', '<leader>ps', function()
      builtin.grep_string({ search = vim.fn.input("Grep > ") })
    end)
    vim.keymap.set('n', '<leader>vh', builtin.help_tags, {})
  end
}
