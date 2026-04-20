return {
  "dmtrKovalenko/fff.nvim",
  build = function()
    require("fff.download").download_or_build_binary()
  end,
  lazy = false,
  opts = {
    prompt_vim_mode = true,
  },
  config = function(_, opts)
    local utils = require("fff.utils")
    local orig_detect = utils.detect_filetype
    utils.detect_filetype = function(file_path)
      if not file_path or file_path == "" then return "" end
      local ok, result = pcall(orig_detect, file_path)
      return ok and result or ""
    end
    require("fff").setup(opts)
  end,
  keys = {
    {
      "ff",
      function() require("fff").find_files() end,
      desc = "FFF: find files",
    },
    {
      "fg",
      function() require("fff").live_grep() end,
      desc = "FFF: live grep",
    },
    {
      "fz",
      function()
        require("fff").live_grep({ grep = { modes = { "fuzzy", "plain" } } })
      end,
      desc = "FFF: fuzzy grep",
    },
    {
      "fc",
      function()
        require("fff").live_grep({ query = vim.fn.expand("<cword>") })
      end,
      desc = "FFF: grep current word",
    },
  },
}
