-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

vim.api.nvim_set_keymap("i", "jk", "<Esc>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("i", "kj", "<Esc>", { noremap = true, silent = true })

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

vim.api.nvim_set_keymap("n", "==", "mmgg=G`m:delmarks m<CR>", { noremap = true, silent = true })
