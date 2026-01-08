return {
  {
    "vim-airline/vim-airline",
    dependencies = {
      "vim-airline/vim-airline-themes",
    },
    config = function()
      -- Airline mode map
      vim.g.airline_mode_map = {
        ['__'] = '-',
        ['n'] = 'N',
        ['i'] = 'I',
        ['R'] = 'R',
        ['c'] = 'C',
        ['v'] = 'V',
        ['V'] = 'V',
        [''] = 'V',
        ['s'] = 'S',
      }

      -- Airline sections
      vim.g.airline_section_z = 'L%3l/%L%3v'
      vim.g['airline#extensions#wordcount#format'] = '%d w'
      vim.g['airline#parts#ffenc#skip_expected_string'] = 'utf-8[unix]'
    end
  },
  {
    "vim-airline/vim-airline-themes",
  }
}
