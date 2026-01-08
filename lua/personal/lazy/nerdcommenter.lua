return {
  "preservim/nerdcommenter",
  keys = {
    { "<leader>cc", mode = { "n", "v" }, desc = "Comment line(s)" },
    { "<leader>cu", mode = { "n", "v" }, desc = "Uncomment line(s)" },
    { "<leader>c<space>", mode = { "n", "v" }, desc = "Toggle comment" },
    { "<leader>cm", mode = { "n", "v" }, desc = "Block comment" },
  },
  config = function()
    vim.g.NERDSpaceDelims = 1
    vim.g.NERDTrimTrailingWhitespace = 1
  end
}
