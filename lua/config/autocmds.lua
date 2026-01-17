-- Autocmds from old config

-- Resize splits on tmux resize
if vim.env.TMUX then
  vim.api.nvim_create_autocmd("VimResized", {
    pattern = "*",
    command = "wincmd =",
    desc = "Resize splits when tmux pane is resized"
  })
end

-- Improve env file detection
vim.api.nvim_create_autocmd({ "BufEnter", "BufNewFile" }, {
  pattern = ".env*",
  command = "set filetype=conf",
  desc = "Set filetype for .env files"
})

-- SCSS iskeyword config
vim.api.nvim_create_autocmd("FileType", {
  pattern = "scss",
  command = "setl iskeyword+=@-@",
  desc = "Add @-@ to iskeyword for SCSS files"
})

-- Remove preview from completeopt
vim.api.nvim_create_autocmd("BufEnter", {
  pattern = "*",
  callback = function()
    vim.opt.completeopt:remove("preview")
  end,
  desc = "Remove preview from completeopt"
})

-- Remove auto-comment formatting
vim.api.nvim_create_autocmd("BufEnter", {
  pattern = "*",
  callback = function()
    vim.opt.formatoptions:remove({ "c", "r", "o" })
  end,
  desc = "Disable auto-comment on newline"
})

-- Remove underscore from iskeyword
vim.api.nvim_create_autocmd("BufEnter", {
  pattern = "*",
  callback = function()
    vim.opt.iskeyword:remove("_")
  end,
  desc = "Remove underscore from iskeyword"
})

-- Split behavior on insert enter/leave
vim.api.nvim_create_autocmd("InsertEnter", {
  pattern = "*",
  command = "set splitbelow",
  desc = "Set splitbelow on insert enter"
})

vim.api.nvim_create_autocmd("InsertLeave", {
  pattern = "*",
  command = "set nosplitbelow",
  desc = "Unset splitbelow on insert leave"
})

-- Disable matchparen (from old config)
vim.g.loaded_matchparen = 1

-- Netrw settings (from old config)
vim.g.netrw_banner = 0
vim.g.netrw_list_hide = '^\\.DS_Store$'

-- JavaScript settings (from old config)
vim.g.javascript_plugin_flow = 1
vim.g.jsx_ext_required = 0

-- ESLint autofix on save for JavaScript/TypeScript files
vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = { "*.js", "*.jsx", "*.ts", "*.tsx", "*.vue" },
  callback = function(args)
    -- Use vim.lsp.buf.format with ESLint as the filter
    vim.lsp.buf.format({
      bufnr = args.buf,
      filter = function(client)
        return client.name == "eslint"
      end,
      timeout_ms = 2000,
    })
  end,
  desc = "Run ESLint autofix before save"
})
