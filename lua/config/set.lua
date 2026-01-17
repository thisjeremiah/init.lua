vim.opt.guicursor = ""

-- Line numbers
vim.opt.nu = true
vim.opt.relativenumber = false

-- Tabs and indentation (from old config: 2 spaces)
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.autoindent = true
vim.opt.smartindent = true

-- Line wrapping
vim.opt.wrap = false

-- Backup and undo
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true

-- Search
vim.opt.hlsearch = false
vim.opt.incsearch = true

-- Appearance
vim.opt.termguicolors = true
vim.opt.cursorline = false
vim.opt.list = false

-- Scrolling and columns
vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"
vim.opt.isfname:append("@-@")

-- Disable horizontal scrolling
vim.opt.sidescroll = 0
vim.opt.sidescrolloff = 0

-- Timing
vim.opt.updatetime = 50
vim.opt.timeoutlen = 300
vim.opt.ttimeoutlen = 0

-- System integration
vim.opt.clipboard = "unnamed"
vim.opt.mouse = "a"

-- Folding
vim.opt.foldlevel = 0
vim.opt.foldmethod = "manual"

-- Performance
vim.opt.lazyredraw = true
