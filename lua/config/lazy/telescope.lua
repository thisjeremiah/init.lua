return {
  "nvim-telescope/telescope.nvim",

  tag = "0.1.5",

  dependencies = {
    "nvim-lua/plenary.nvim"
  },

  config = function()
    require('telescope').setup({})

    local builtin = require('telescope.builtin')

    -- Old config FZF-style keymaps (prioritized)
    vim.keymap.set('n', '<leader>a', builtin.live_grep, { desc = "Search in files (Ag)" })
    vim.keymap.set('n', '<leader>b', function()
      builtin.buffers({
        sort_mru = true,
        sort_lastused = true,
        ignore_current_buffer = true
      })
    end, { desc = "List buffers (MRU)" })
    vim.keymap.set('n', '<leader>o', builtin.find_files, { desc = "Find files" })

    -- Create :Ag command for old workflow
    vim.api.nvim_create_user_command('Ag', function(opts)
      builtin.live_grep({ default_text = opts.args })
    end, { nargs = '*', desc = "Live grep (like :Ag)" })

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
