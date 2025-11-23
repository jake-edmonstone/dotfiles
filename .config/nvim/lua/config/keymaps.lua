-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- vim.api.nvim_set_keymap("i", "jk", "<Esc>", { noremap = true, silent = true })
-- vim.api.nvim_set_keymap("i", "kj", "<Esc>", { noremap = true, silent = true })

-- move cursor back after yank in visual mode
vim.api.nvim_set_keymap("v", "y", "ygv<Esc>", { noremap = true, silent = true })

-- make changing in any mode not replace register
vim.api.nvim_set_keymap("n", "c", '"_c', { noremap = true, silent = true })
vim.api.nvim_set_keymap("v", "c", '"_c', { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "C", '"_C', { noremap = true, silent = true })
vim.api.nvim_set_keymap("v", "C", '"_C', { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "x", '"_x', { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "X", '"_X', { noremap = true, silent = true })

-- provides a way to delete without copying
vim.keymap.set("n", "<leader>d", '"_d', { desc = "Delete to black hole", silent = true })
vim.keymap.set("v", "<leader>d", '"_d', { desc = "Delete to black hole", silent = true })

--vim.keymap.set("n", "==", "mzgg=G`z", { desc = "indent whole file", silent = true })

vim.keymap.set("n", "==", function()
  local cur = vim.api.nvim_win_get_cursor(0)
  vim.cmd("normal! gg=G")
  vim.api.nvim_win_set_cursor(0, cur)
end, { desc = "Indent whole file", silent = true })

vim.keymap.set("n", "<Tab>", function()
  local word = vim.fn.expand("<cword>")
  local suggestions = vim.fn.spellsuggest(word, 1)
  if #suggestions > 0 then
    vim.cmd.normal("ciw" .. suggestions[1])
  end
end, { noremap = true, silent = true, desc = "Replace with first spelling suggestion" })

vim.keymap.set("n", "<leader>i", "<C-i>", { noremap = true, silent = true })

vim.keymap.set("n", "<C-u>", "<C-u>zz", { noremap = true, silent = true })
vim.keymap.set("n", "<C-d>", "<C-d>zz", { noremap = true, silent = true })

-- select mode and luasnip jumping
local ls = require("luasnip")
local function t(keys)
  return vim.api.nvim_replace_termcodes(keys, true, true, true)
end
local function jump_or_move(dir)
  if ls.jumpable(dir) then
    ls.jump(dir)
  else
    local key = dir == 1 and "<Right>" or "<Left>"
    vim.api.nvim_feedkeys(t(key), "n", false)
  end
end
vim.keymap.set({ "i", "s" }, "<C-l>", function()
  jump_or_move(1)
end, { silent = true })
vim.keymap.set({ "i", "s" }, "<C-h>", function()
  jump_or_move(-1)
end, { silent = true })
