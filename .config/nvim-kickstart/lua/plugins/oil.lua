return {
	{
		"stevearc/oil.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		cmd = { "Oil" }, -- keep lazy-loading by command
		-- lazy = false,
		keys = {
			{
				"<leader>fo",
				function()
					local oil = require("oil")
					local bufnr = vim.api.nvim_get_current_buf()
					if vim.bo[bufnr].filetype == "oil" then
						vim.cmd("q") -- close if already in Oil
					else
						oil.open_float()
					end
				end,
				desc = "Toggle Oil",
			},
		},
		opts = {
			view_options = { show_hidden = true },
			float = {
				padding = 5,
				border = "rounded",
			},
			--default_file_explorer = true,
		},
	},
	{
		"nvim-mini/mini.files",
		lazy = false,
		opts = {
			options = {
				use_as_default_explorer = true,
			},
			windows = {
				preview = true,
				width_focus = 30,
				width_preview = 30,
			},
			mappings = {
				close = "q",
				go_in = "",
				go_in_plus = "<Enter>",
				go_out = "-",
				go_out_plus = "",
				mark_goto = "'",
				mark_set = "m",
				reset = "<BS>",
				reveal_cwd = "@",
				show_help = "g?",
				synchronize = "=",
				trim_left = "<",
				trim_right = ">",
			},
		},
		keys = {
			{
				"<leader>o",
				function()
					local MiniFiles = require("mini.files")
					if not MiniFiles.close() then
						MiniFiles.open(vim.api.nvim_buf_get_name(0), true)
					end
				end,
				desc = "Toggle mini.files (Directory of Current File)",
			},
			{
				"<leader>O",
				function()
					local MiniFiles = require("mini.files")
					if not MiniFiles.close() then
						MiniFiles.open(vim.uv.cwd(), true)
					end
				end,
				desc = "Toggle mini.files (cwd)",
			},
		},
	},
}
