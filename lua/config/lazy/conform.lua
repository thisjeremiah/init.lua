return {
  "stevearc/conform.nvim",
  opts = {},
  config = function()
    -- Global variable to track formatting state
    vim.g.autoformat_enabled = true

    require("conform").setup({
      format_on_save = function(bufnr)
        -- Check if formatting is enabled
        if not vim.g.autoformat_enabled then
          return nil
        end
        return {
          timeout_ms = 10000,
          lsp_format = "fallback",
        }
      end,
      formatters_by_ft = {
        c = { "clang-format" },
        cpp = { "clang-format" },
        lua = { "stylua" },
        go = { "gofmt" },
        javascript = { "prettier" },
        javascriptreact = { "prettier" },
        typescript = { "prettier" },
        typescriptreact = { "prettier" },
        vue = { "prettier" },
        css = { "prettier" },
        scss = { "prettier" },
        less = { "prettier" },
        html = { "prettier" },
        json = { "prettier" },
        jsonc = { "prettier" },
        yaml = { "prettier" },
        markdown = { "prettier" },
        graphql = { "prettier" },
        handlebars = { "prettier" },
        elixir = { "mix" },
        python = { "ruff_fix", "ruff_organize_imports", "black" },
      },
      formatters = {
        ["clang-format"] = {
          prepend_args = { "-style=file", "-fallback-style=LLVM" },
        },
        black = {
          timeout_ms = 10000,
          prepend_args = { "--fast" },  -- Use Black's fast mode to speed up formatting
        },
        ruff_fix = {
          command = "ruff",
          args = {
            "check",
            "--fix",
            "--exit-zero",
            "--stdin-filename",
            "$FILENAME",
            "-",
          },
          stdin = true,
          cwd = require("conform.util").root_file({
            "pyproject.toml",
            "ruff.toml",
            ".ruff.toml",
          }),
        },
        ruff_organize_imports = {
          command = "ruff",
          args = {
            "check",
            "--select=I",
            "--fix",
            "--exit-zero",
            "--stdin-filename",
            "$FILENAME",
            "-",
          },
          stdin = true,
          cwd = require("conform.util").root_file({
            "pyproject.toml",
            "ruff.toml",
            ".ruff.toml",
          }),
        },
      },
    })

    vim.keymap.set("n", "<leader>f", function()
      require("conform").format({ bufnr = 0, timeout_ms = 10000 })
    end)

    -- Toggle formatting on/off
    vim.keymap.set("n", "<leader>tf", function()
      vim.g.autoformat_enabled = not vim.g.autoformat_enabled
      if vim.g.autoformat_enabled then
        vim.notify("Autoformat enabled", vim.log.levels.INFO)
      else
        vim.notify("Autoformat disabled", vim.log.levels.WARN)
      end
    end, { desc = "Toggle autoformat on save" })

    -- User commands for easy access
    vim.api.nvim_create_user_command("FormatDisable", function()
      vim.g.autoformat_enabled = false
      vim.notify("Autoformat disabled", vim.log.levels.WARN)
    end, { desc = "Disable autoformat on save" })

    vim.api.nvim_create_user_command("FormatEnable", function()
      vim.g.autoformat_enabled = true
      vim.notify("Autoformat enabled", vim.log.levels.INFO)
    end, { desc = "Enable autoformat on save" })

    vim.api.nvim_create_user_command("FormatToggle", function()
      vim.g.autoformat_enabled = not vim.g.autoformat_enabled
      if vim.g.autoformat_enabled then
        vim.notify("Autoformat enabled", vim.log.levels.INFO)
      else
        vim.notify("Autoformat disabled", vim.log.levels.WARN)
      end
    end, { desc = "Toggle autoformat on save" })
  end,
}
