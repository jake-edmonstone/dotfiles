-- [[ Basic Autocommands ]]

-- Highlight when yanking text
vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight when yanking (copying) text",
	group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
	callback = function()
		vim.hl.on_yank({ timeout = 200 })
	end,
})

-- Restore cursor position on file open
vim.api.nvim_create_autocmd("BufReadPost", {
	desc = "Restore cursor position on file open",
	group = vim.api.nvim_create_augroup("kickstart-restore-cursor", { clear = true }),
	pattern = "*",
	callback = function()
		local line = vim.fn.line("'\"")
		if line > 1 and line <= vim.fn.line("$") then
			vim.cmd("normal! g'\"")
		end
	end,
})

-- Disable auto comment on new line
vim.api.nvim_create_augroup("FormatOptions", { clear = true })
vim.api.nvim_create_autocmd("BufEnter", {
	pattern = "*",
	command = "set formatoptions-=ro",
	group = "FormatOptions",
})

-- Auto reload files on focus/buffer change
vim.o.autoread = true
vim.api.nvim_create_autocmd({ "FocusGained", "BufEnter" }, {
	command = "if mode() != 'c' | checktime | endif",
	pattern = "*",
})

-- XML filetype settings
vim.api.nvim_create_autocmd("FileType", {
	pattern = "xml",
	callback = function()
		vim.bo.shiftwidth = 4
		vim.bo.tabstop = 4
		vim.bo.softtabstop = 4
		vim.bo.expandtab = true
	end,
})
