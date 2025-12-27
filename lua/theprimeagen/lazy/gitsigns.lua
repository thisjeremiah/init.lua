return {
    "lewis6991/gitsigns.nvim",
    config = function()
        require('gitsigns').setup({
            signs = {
                add          = { text = '+' },
                change       = { text = '~' },
                delete       = { text = '_' },
                topdelete    = { text = '‾' },
                changedelete = { text = '~' },
            },
            on_attach = function(bufnr)
                local gs = package.loaded.gitsigns

                local function map(mode, l, r, opts)
                    opts = opts or {}
                    opts.buffer = bufnr
                    vim.keymap.set(mode, l, r, opts)
                end

                -- Navigation (from old config)
                map('n', ']g', function()
                    if vim.wo.diff then return ']g' end
                    vim.schedule(function() gs.next_hunk() end)
                    return '<Ignore>'
                end, { expr = true, desc = "Next git hunk" })

                map('n', '[g', function()
                    if vim.wo.diff then return '[g' end
                    vim.schedule(function() gs.prev_hunk() end)
                    return '<Ignore>'
                end, { expr = true, desc = "Previous git hunk" })

                -- Show chunk diff at current position
                map('n', 'gs', gs.preview_hunk, { desc = "Show git chunk diff" })

                -- Show commit contains current position
                map('n', 'gc', gs.blame_line, { desc = "Show git blame" })

                -- Text objects for git chunks
                map({'o', 'x'}, 'ig', ':<C-U>Gitsigns select_hunk<CR>', { desc = "Select git hunk (inner)" })
                map({'o', 'x'}, 'ag', ':<C-U>Gitsigns select_hunk<CR>', { desc = "Select git hunk (around)" })

                -- Stage/unstage hunks
                map('n', '<leader>hs', gs.stage_hunk, { desc = "Stage hunk" })
                map('n', '<leader>hr', gs.reset_hunk, { desc = "Reset hunk" })
                map('n', '<leader>hS', gs.stage_buffer, { desc = "Stage buffer" })
                map('n', '<leader>hu', gs.undo_stage_hunk, { desc = "Undo stage hunk" })
                map('n', '<leader>hR', gs.reset_buffer, { desc = "Reset buffer" })
                map('n', '<leader>hp', gs.preview_hunk, { desc = "Preview hunk" })
                map('n', '<leader>hb', function() gs.blame_line{full=true} end, { desc = "Blame line (full)" })
                map('n', '<leader>tb', gs.toggle_current_line_blame, { desc = "Toggle git blame line" })
                map('n', '<leader>hd', gs.diffthis, { desc = "Diff this" })
                map('n', '<leader>hD', function() gs.diffthis('~') end, { desc = "Diff this ~" })
                map('n', '<leader>td', gs.toggle_deleted, { desc = "Toggle deleted" })
            end
        })
    end
}
