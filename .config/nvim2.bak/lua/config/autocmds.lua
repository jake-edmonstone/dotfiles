-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here

-- Makes it so it doesn't start comment lines automatically
vim.api.nvim_create_augroup("FormatOptions", { clear = true })
vim.api.nvim_create_autocmd("BufEnter", {
  pattern = "*",
  command = "set formatoptions-=ro",
  group = "FormatOptions",
})

-- Autosave
vim.api.nvim_create_autocmd({ "FocusLost", "BufLeave" }, {
  pattern = { "*" },
  command = "silent! wall",
  nested = true,
})

-- Make cursor line lighter
vim.api.nvim_create_autocmd({ "BufWinEnter", "WinEnter" }, {
  pattern = "*",
  callback = function()
    vim.api.nvim_set_hl(0, "CursorLine", { bg = "#2E303E" })
  end,
})
