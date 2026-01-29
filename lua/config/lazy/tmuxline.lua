return {
  "edkolev/tmuxline.vim",
  -- Not lazy loading because vim-airline's tmuxline extension needs it at startup
  config = function()
    vim.g.tmuxline_powerline_separators = 0
    vim.g.tmuxline_preset = {
      a = '#S',
      win = '#I #W #{s|$HOME||;s|/.*/||:pane_current_path}',
      cwin = '#I #W #{s|$HOME||;s|/.*/||:pane_current_path}',
      options = {
        ['status-justify'] = 'left'
      }
    }
    -- Note: Run :TmuxlineSnapshot ~/.tmuxline_snapshot.conf
    -- to have the tmux preset load immediately when tmux starts
  end
}
