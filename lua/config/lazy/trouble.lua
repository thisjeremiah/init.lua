return {
  {
    "folke/trouble.nvim",
    keys = {
      { "<leader>tt", desc = "Toggle trouble diagnostics" },
      { "<leader>td", desc = "Toggle trouble buffer diagnostics" },
      { "[t", desc = "Next trouble item" },
      { "]t", desc = "Previous trouble item" },
    },
    config = function()
      require("trouble").setup({
        icons = {
          indent = {
            middle = " ",
            last = " ",
            top = " ",
            ws = "  ",
          },
          folder_closed = "",
          folder_open = "",
        },
        use_diagnostic_signs = false,
      })

      -- Override Trouble's default highlight links to use Normal instead of NormalFloat
      -- This fixes the black background issue with base16 themes
      local function setup_trouble_highlights()
        vim.api.nvim_set_hl(0, "TroubleNormal", { link = "Normal" })
        vim.api.nvim_set_hl(0, "TroubleNormalNC", { link = "Normal" })
      end

      -- Apply immediately
      setup_trouble_highlights()

      -- Re-apply when colorscheme changes (since Trouble might reset them)
      vim.api.nvim_create_autocmd("ColorScheme", {
        callback = setup_trouble_highlights,
      })

      vim.keymap.set("n", "<leader>tt", function()
        require("trouble").toggle("diagnostics")
      end)

      vim.keymap.set("n", "<leader>td", function()
        require("trouble").toggle("diagnostics", { filter = { buf = 0 } })
      end)

      vim.keymap.set("n", "[t", function()
        require("trouble").next({ skip_groups = true, jump = true });
      end)

      vim.keymap.set("n", "]t", function()
        require("trouble").previous({ skip_groups = true, jump = true });
      end)
    end
  },
}
