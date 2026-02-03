-- Auto-reload files changed externally (e.g., by Claude Code)
-- Uses libuv fs_event to watch for changes

local M = {}

-- Debounce timer
local debounce_timer = nil
local debounce_ms = 100

-- Patterns to ignore
local ignore_patterns = {
  "^%.git/",
  "^%.git$",
  "/%.git/",
  "node_modules/",
  "^node_modules$",
}

local function should_ignore(path)
  for _, pattern in ipairs(ignore_patterns) do
    if path:match(pattern) then
      return true
    end
  end
  return false
end

local function reload_buffers()
  -- Check for external changes on all buffers
  vim.cmd("checktime")

  -- Refresh gitsigns if available
  local ok, gitsigns = pcall(require, "gitsigns")
  if ok then
    gitsigns.refresh()
  end
end

local function debounced_reload()
  if debounce_timer then
    debounce_timer:stop()
  end

  debounce_timer = vim.defer_fn(function()
    reload_buffers()
    debounce_timer = nil
  end, debounce_ms)
end

local function setup_watcher()
  local handle = vim.uv.new_fs_event()
  if not handle then
    return
  end

  local flags = {
    recursive = true,
  }

  handle:start(vim.fn.getcwd(), flags, function(err, filename)
    if err then
      return
    end

    if filename and should_ignore(filename) then
      return
    end

    vim.schedule(debounced_reload)
  end)

  -- Clean up on exit
  vim.api.nvim_create_autocmd("VimLeavePre", {
    callback = function()
      if handle then
        handle:stop()
      end
    end,
  })
end

-- Fallback: also reload on focus/enter events
vim.api.nvim_create_autocmd({ "FocusGained", "BufEnter", "CursorHold" }, {
  callback = function()
    if vim.fn.getcmdwintype() == "" then
      vim.cmd("checktime")
    end
  end,
  desc = "Check for external file changes",
})

-- Auto-read changed files without prompting
vim.o.autoread = true

-- Start the watcher
setup_watcher()

-- Return empty table for lazy.nvim compatibility
return {}
