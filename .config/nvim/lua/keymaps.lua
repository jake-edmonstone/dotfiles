-- [[ Basic Keymaps ]]
--  See `:help vim.keymap.set()`

-- Set highlight on search, but clear on pressing <Esc> in normal mode
vim.opt.hlsearch = true
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Diagnostic keymaps
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous [D]iagnostic message' })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next [D]iagnostic message' })
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Show diagnostic [E]rror messages' })
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
-- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
-- is not what someone will guess without a bit more experience.
--
-- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
-- or just use <C-\><C-n> to exit terminal mode
vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

-- Keybinds to make split navigation easier.
--  Use CTRL+<hjkl> to switch between windows
--
--  See `:help wincmd` for a list of all window commands
vim.keymap.set('n', '<leader>h', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<leader>l', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<leader>j', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<leader>k', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

vim.keymap.set('n', '<C-l>', ':bn<CR>', { desc = 'Next Buffer', silent = true })
vim.keymap.set('n', '<C-h>', ':bp<CR>', { desc = 'Previous Buffer', silent = true })

-- [[ Basic Autocommands ]]
--  See `:help lua-guide-autocommands`

-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.highlight.on_yank()`
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- move cursor back after yank in visual mode
vim.api.nvim_set_keymap('v', 'y', 'ygv<Esc>', { noremap = true, silent = true })

-- auto close }
vim.api.nvim_set_keymap('i', '{<CR>', '{<CR>}<Esc>O', { noremap = true, silent = true })
vim.api.nvim_set_keymap('i', '{<S-CR>', '{<CR>}<Esc>O', { noremap = true, silent = true })

-- kj and jk to enter normal mode
vim.api.nvim_set_keymap('i', 'kj', '<Esc>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('i', 'jk', '<Esc>l', { noremap = true, silent = true })

-- make pasting in visual mode not replace the register
vim.api.nvim_set_keymap('v', 'p', 'p`]mm`[v`]=`m:delmarks m<CR>', { noremap = true, silent = true })
-- pasting in visual mode with replace register
--vim.api.nvim_set_keymap('v', '<leader>p', 'p`]mm`[v`]=`m:delmarks m<CR>', { noremap = true, silent = true })

-- makes the cursor go to the end of the pasted text
vim.api.nvim_set_keymap('n', 'p', 'p`]mm`[v`]=`m:delmarks m<CR>', { noremap = true, silent = true })

-- make changing in any mode not replace register
vim.api.nvim_set_keymap('n', 'c', '"_c', { noremap = true, silent = true })
vim.api.nvim_set_keymap('v', 'c', '"_c', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', 'x', '"_x', { noremap = true, silent = true })

-- provides a way to delete without copying
vim.keymap.set('n', '<leader>d', '"_d', { desc = 'Delete to black hole', silent = true })
vim.keymap.set('v', '<leader>d', '"_d', { desc = 'Delete to black hole', silent = true })

vim.keymap.set('n', '<c-d>', '<c-d>zz', { desc = 'less disorienting scrolling', silent = true })
vim.keymap.set('n', '<c-u>', '<c-u>zz', { desc = 'less disorienting scrolling', silent = true })

-- makes == format the whole document
vim.api.nvim_set_keymap('n', '<Leader>==', '<cmd>lua require("conform").format()<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '==', 'mmgg=G`m:delmarks m<CR>', { noremap = true, silent = true })

-- NvimTree commands t for tree toggle, g for goto file
vim.api.nvim_set_keymap('n', '<Leader>t', ':NvimTreeToggle<CR>', { noremap = true, silent = true })
-- vim.api.nvim_set_keymap('n', '<Leader>g', ':NvimTreeFindFile<CR>', { noremap = true, silent = true })

-- Spider keymaps
vim.keymap.set(
  { "n", "o", "x" },
  "w",
  "<cmd>lua require('spider').motion('w')<CR>",
  { desc = "Spider-w" }
)
vim.keymap.set(
  { "n", "o", "x" },
  "e",
  "<cmd>lua require('spider').motion('e')<CR>",
  { desc = "Spider-e" }
)
vim.keymap.set(
  { "n", "o", "x" },
  "b",
  "<cmd>lua require('spider').motion('b')<CR>",
  { desc = "Spider-b" }
)
-- vim: ts=2 sts=2 sw=2 et
