vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.g.have_nerd_font = true

-- Load configuration modules
require("config.options")
require("config.keymaps")
require("config.diagnostic")
require("config.autocmds")
require("config.lazy")

-- vim: ts=2 sts=2 sw=2 et
