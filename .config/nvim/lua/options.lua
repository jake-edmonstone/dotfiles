-- [[ Setting options ]]
-- See `:help vim.opt`
-- NOTE: You can change these options as you wish!
--  For more options, you can see `:help option-list`

-- Removes the : from indent keys so typing it cannot change indentation
vim.cmd [[
  augroup GeneralIndent
    autocmd!
    autocmd FileType * setlocal indentkeys-=:
  augroup END
]]

vim.opt.pumheight = 5 -- limits height of pop up
vim.opt.tabstop = 2 -- Set the width of a tab character
vim.opt.shiftwidth = 2 -- Set the width of an indentation
vim.opt.expandtab = true -- Convert tabs to spaces

-- Auto save with a timer
local debounce_timer
vim.api.nvim_create_autocmd({ 'InsertLeave', 'TextChanged' }, {
  pattern = '*',
  callback = function()
    if debounce_timer then
      vim.fn.timer_stop(debounce_timer)
    end
    debounce_timer = vim.fn.timer_start(100, function()
      vim.cmd 'silent! update'
    end)
  end,
})

-- Changes the current directory in all buffers to most recent
vim.api.nvim_create_autocmd("DirChanged", {
  pattern = "*",
  callback = function()
    vim.cmd("silent! cd " .. vim.fn.getcwd())
  end,
})

-- Make line numbers default
vim.opt.number = true
-- You can also add relative line numbers, for help with jumping.
--  Experiment for yourself to see if you like it!
vim.opt.relativenumber = true

-- Enable mouse mode, can be useful for resizing splits for example!
vim.opt.mouse = 'a'

-- Make cursor blinking
vim.opt.guicursor = 'n:blinkon1,i:ver25,i:blinkon1'

-- Don't show the mode, since it's already in status line
vim.opt.showmode = false

-- Sync clipboard between OS and Neovim.
--  Remove this option if you want your OS clipboard to remain independent.
--  See `:help 'clipboard'`
vim.opt.clipboard = 'unnamedplus'

-- Enable break indent
vim.opt.breakindent = true

-- Save undo history
vim.opt.undofile = true

-- Case-insensitive searching UNLESS \C or capital in search
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Keep signcolumn on by default
vim.opt.signcolumn = 'yes'

-- Decrease update time
vim.opt.updatetime = 250
vim.opt.timeoutlen = 1000

-- Configure how new splits should be opened
vim.opt.splitright = true
vim.opt.splitbelow = true

-- Sets how neovim will display certain whitespace in the editor.
--  See `:help 'list'`
--  and `:help 'listchars'`
vim.opt.list = true
vim.opt.listchars = { tab = '  ', trail = ' ', nbsp = '␣' }

-- Preview substitutions live, as you type!
vim.opt.inccommand = 'split'

-- Show which line your cursor is on
vim.opt.cursorline = true

-- Minimal number of screen lines to keep above and below the cursor.
vim.opt.scrolloff = 10


-- Configure the LSP hover handler to include a border
vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(
  vim.lsp.handlers.hover,
  {
    -- Define border style: single, double, rounded, solid, shadow, or a custom list
    border = "rounded"
  }
)

-- vim: ts=2 sts=2 sw=2 et
