return {
  "stevearc/oil.nvim",
  config = function()
    require("oil").setup({
      default_file_explorer = true,
      view_options = {
        show_hidden = true,
      },
    })

    -- Define a function to open oil in a specified split
    local function open_oil_in_split(split_command, dir)
      dir = dir or vim.fn.getcwd()
      vim.cmd(split_command)
      require('oil').open()
    end

    -- Remap :Ex
    vim.api.nvim_create_user_command('Ex', function(opts)
      require('oil').open()
    end, { nargs = '?' })

    -- Remap :Hex (horizontal split)
    vim.api.nvim_create_user_command('Hex', function(opts)
      local dir = opts.fargs[1]
      open_oil_in_split('split', dir)
    end, { nargs = '?' })

    -- Remap :Vex (vertical split)
    vim.api.nvim_create_user_command('Vex', function(opts)
      local dir = opts.fargs[1]
      open_oil_in_split('vsplit', dir)
    end, { nargs = '?' })
  end
}
