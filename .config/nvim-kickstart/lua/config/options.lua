-- [[ Setting options ]]
vim.o.number = true
vim.o.mouse = "a"
vim.o.showmode = false
vim.schedule(function()
	vim.o.clipboard = "unnamedplus"
end)
vim.o.breakindent = true
vim.o.undofile = true
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.signcolumn = "yes"
vim.o.updatetime = 250
vim.o.timeoutlen = 300
vim.o.inccommand = "split"
vim.o.cursorline = true
vim.o.scrolloff = 10
vim.o.confirm = true
vim.o.wrap = true
vim.o.cmdheight = 0

-- Window borders
vim.o.winborder = "rounded"

-- Tab settings
vim.o.tabstop = 2
vim.o.shiftwidth = 2
vim.o.softtabstop = 2
vim.o.expandtab = true

-- Additional options from main nvim config
vim.opt.list = false
vim.opt.swapfile = false
vim.opt.guicursor = "n-v-c-sm:block-blinkwait700-blinkon400-blinkoff250,i-ci-ve:ver25-blinkwait700-blinkon400-blinkoff250,r-cr-o:hor20"
vim.g.root_spec = { "cwd" } -- Use directory nvim was started in, not git repo
vim.lsp.set_log_level("off")
