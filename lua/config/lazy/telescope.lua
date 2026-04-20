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
          -- Explicitly ignore heavy/derived dirs
          '--glob',
          '!node_modules/**',
          '--glob',
          '!.next/**',
          '--glob',
          '!dist/**',
          '--glob',
          '!build/**',
          '--glob',
          '!vendor/**',
          '--glob',
          '!.git/**',
        },
      },
      pickers = {
        live_grep = {
          -- Remove the empty additional_args to avoid any issues
        },
      },
    })

    local builtin = require('telescope.builtin')

    vim.keymap.set('n', '<leader>b', function()
      builtin.buffers({
        sort_mru = true,
        sort_lastused = true,
        ignore_current_buffer = true
      })
    end, { desc = "List buffers (MRU)" })

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
        '--glob',
        '!node_modules/**',
        '--glob',
        '!.next/**',
        '--glob',
        '!dist/**',
        '--glob',
        '!build/**',
        '--glob',
        '!vendor/**',
        '--glob',
        '!.git/**',
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
