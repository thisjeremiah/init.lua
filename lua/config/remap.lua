vim.g.mapleader = " "

-- Exit with esc
vim.keymap.set("i", "jk", "<Esc>", { noremap = true, desc = "Exit insert mode" })
vim.keymap.set("t", "<Esc>", "<C-\\><C-n>", { noremap = true, desc = "Exit terminal mode" })

-- Toggle split layout
local function toggle_layout()
  local splitbelow = vim.o.splitbelow
  local splitright = vim.o.splitright

  if splitbelow and splitright then
    vim.o.splitbelow = false
    vim.o.splitright = false
    vim.cmd("wincmd K") -- Convert to horizontal layout
  else
    vim.o.splitbelow = true
    vim.o.splitright = true
    vim.cmd("wincmd H") -- Convert to vertical layout
  end
end

vim.keymap.set("n", "<leader>tl", toggle_layout, { desc = "Toggle split layout" })

vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

vim.api.nvim_set_keymap("n", "<leader>tf", "<Plug>PlenaryTestFile", { noremap = false, silent = false })

vim.keymap.set("n", "J", "mzJ`z")
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")
vim.keymap.set("n", "=ap", "ma=ap'a")
vim.keymap.set("n", "<leader>zig", "<cmd>LspRestart<cr>")

-- greatest remap ever
vim.keymap.set("x", "<leader>p", [["_dP]])

-- next greatest remap ever : asbjornHaland
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]])
vim.keymap.set("n", "<leader>Y", [["+Y]])

-- Yank with file path (for Claude Code context)
local function yank_with_path(use_absolute)
  local start_line = vim.fn.line("'<")
  local end_line = vim.fn.line("'>")
  local filepath = use_absolute and vim.fn.expand("%:p") or vim.fn.expand("%:.")

  -- Get selected lines
  local lines = vim.fn.getline(start_line, end_line)
  if type(lines) == "string" then
    lines = { lines }
  end

  -- Build path header
  local path_header
  if start_line == end_line then
    path_header = filepath .. ":" .. start_line
  else
    path_header = filepath .. ":" .. start_line .. "-" .. end_line
  end

  -- Combine path and code
  local content = path_header .. "\n" .. table.concat(lines, "\n")

  -- Copy to system clipboard
  vim.fn.setreg("+", content)

  -- Exit visual mode (like regular y)
  vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Esc>", true, false, true), "n", false)

  vim.notify("Yanked with " .. (use_absolute and "absolute" or "relative") .. " path", vim.log.levels.INFO)
end

vim.keymap.set("v", "yr", function() yank_with_path(false) end, { desc = "Yank with relative path" })
vim.keymap.set("v", "ya", function() yank_with_path(true) end, { desc = "Yank with absolute path" })


-- This is going to get me cancelled
vim.keymap.set("i", "<C-c>", "<Esc>")

vim.keymap.set("n", "Q", "<nop>")
vim.keymap.set("n", "<C-f>", "<cmd>silent !tmux neww tmux-sessionizer<CR>")
vim.keymap.set("n", "<M-h>", "<cmd>silent !tmux-sessionizer -s 0 --vsplit<CR>")
vim.keymap.set("n", "<M-H>", "<cmd>silent !tmux neww tmux-sessionizer -s 0<CR>")

vim.keymap.set("n", "<C-k>", "<cmd>cnext<CR>zz")
vim.keymap.set("n", "<C-j>", "<cmd>cprev<CR>zz")
vim.keymap.set("n", "<leader>k", "<cmd>lnext<CR>zz")
vim.keymap.set("n", "<leader>j", "<cmd>lprev<CR>zz")

vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])

vim.keymap.set("n", "<leader><leader>", function()
  vim.cmd("so")
end)
