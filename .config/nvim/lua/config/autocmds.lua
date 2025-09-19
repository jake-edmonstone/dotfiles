-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
-- e.g. vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")

vim.api.nvim_create_augroup("FormatOptions", { clear = true })
vim.api.nvim_create_autocmd("BufEnter", {
  pattern = "*",
  command = "set formatoptions-=ro",
  group = "FormatOptions",
})

vim.o.autoread = true
vim.api.nvim_create_autocmd({ "FocusGained", "BufEnter" }, {
  command = "if mode() != 'c' | checktime | endif",
  pattern = "*",
})

vim.api.nvim_create_autocmd("ColorScheme", {
  callback = function()
    vim.api.nvim_set_hl(0, "BufferLineBufferSelected", { fg = "NONE" })
    vim.api.nvim_set_hl(0, "TabLineFill", { fg = "NONE" })
    vim.api.nvim_set_hl(0, "BufferLineFill", { fg = "NONE" })
    vim.api.nvim_set_hl(0, "StatusLine", { bg = "#191A21" })
  end,
})
