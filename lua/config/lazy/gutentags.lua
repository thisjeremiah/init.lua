return {
  {
    "ludovicchabant/vim-gutentags",
    init = function()
      local cache_dir = vim.fn.stdpath("data") .. "/gutentags"
      vim.fn.mkdir(cache_dir, "p")

      vim.g.gutentags_cache_dir = cache_dir
      vim.g.gutentags_ctags_executable = "ctags"
      vim.g.gutentags_project_root = { ".git" }
      vim.g.gutentags_generate_on_missing = 1
      vim.g.gutentags_generate_on_new = 1
      vim.g.gutentags_generate_on_write = 1
      vim.g.gutentags_background_update = 1
      vim.g.gutentags_ctags_exclude = {
        "node_modules",
        "vendor",
        "dist",
        "build",
        ".git",
        ".hg",
        ".svn",
        ".cache",
        ".tox",
        ".venv",
        ".next",
        "target",
      }
    end,
  },
}
