return {
	{
		"Mofiqul/dracula.nvim",
		lazy = false, -- make sure we load this during startup if it is your main colorscheme
		priority = 1000, -- make sure to load this before all the other start plugins
		config = function()
			require("dracula").setup({
				transparent_bg = true,
			})
			vim.cmd.colorscheme("dracula")
			vim.api.nvim_set_hl(0, "CursorLine", { bg = "#2E303E" })
			vim.api.nvim_set_hl(0, "NormalFloat", { bg = "NONE", ctermbg = "NONE" })
			vim.api.nvim_set_hl(0, "BufferLineBufferSelected", { fg = "NONE" })
			vim.api.nvim_set_hl(0, "TabLineFill", { fg = "NONE" })
			vim.api.nvim_set_hl(0, "BufferLineFill", { fg = "NONE" })
			vim.api.nvim_set_hl(0, "StatusLine", { bg = "NONE" })
			vim.api.nvim_set_hl(0, "StatusLineTerm", { bg = "NONE" })
			vim.api.nvim_set_hl(0, "StatusLineTermNC", { bg = "NONE" })
			vim.api.nvim_set_hl(0, "MiniFilesNormal", { bg = "NONE" })
			vim.api.nvim_set_hl(0, "MiniFilesBorder", { bg = "NONE" })
		end,
	},
}
