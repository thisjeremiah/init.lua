return {
    "stevearc/oil.nvim",
    config = function()
        require("oil").setup({
            default_file_explorer = true,
            view_options = {
                show_hidden = true,
            },
            float = {
                padding = 6,
                border = "rounded",
                win_options = {
                    winhighlight = 'Normal:Normal,FloatBorder:FloatBorder'
                },
            },
        })

        -- Custom keymap for closing Oil.nvim float
        vim.keymap.set("n", "<ESC>", function()
            local current_win = vim.api.nvim_get_current_win()
            local current_buf = vim.api.nvim_win_get_buf(current_win)
            local is_oil_buffer = vim.bo[current_buf].filetype == "oil"
            local win_config = vim.api.nvim_win_get_config(current_win)
            local is_float_window = win_config and win_config.relative ~= ''

            if is_oil_buffer and is_float_window then
                require("oil").close()
            else
                vim.cmd("normal! <ESC>")
            end
        end, { desc = "Close Oil.nvim float or default ESC" })

        -- Key for opening Oil in a floating window
        vim.keymap.set("n", "<leader>e", function()
            require("oil").open_float()
        end, { desc = "Open oil in a floating window" })

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

        -- FloatBorder highlight
        vim.api.nvim_set_hl(0, "FloatBorder", {})
    end
}
