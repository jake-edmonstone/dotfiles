-- Snacks.nvim - Swiss Army Knife for Neovim
return {
	"folke/snacks.nvim",
	priority = 1000,
	lazy = false,
	opts = {
		bigfile = { enabled = true },
		notifier = { enabled = true },
		quickfile = { enabled = true },
		statuscolumn = { enabled = true },
		words = { enabled = true },
		explorer = { enabled = false },
		picker = {
			win = {
				preview = {
					wo = {
						wrap = true,
					},
				},
				input = {
					keys = {
						["<a-c>"] = {
							"toggle_cwd",
							mode = { "n", "i" },
						},
						["<a-t>"] = {
							"trouble_open",
							mode = { "n", "i" },
						},
					},
				},
			},
			sources = {
				files = { hidden = true },
			},
			sources = {
				files = { hidden = true },
				explorer = { layout = { layout = { position = "right" } } },
			},
			layout = { preset = "default" },
			hidden = true,
			actions = {
				---@param p snacks.Picker
				toggle_cwd = function(p)
					local cwd = vim.fs.normalize((vim.uv or vim.loop).cwd() or ".")
					local current = p:cwd()
					p:set_cwd(current == cwd and vim.fn.getcwd() or cwd)
					p:find()
				end,
				trouble_open = function(picker)
					local trouble = require("trouble")
					local items = picker:selected_or_current()
					if #items == 0 then
						return
					end
					trouble.open({
						mode = "quickfix",
						items = items,
					})
				end,
			},
		},
	},
	keys = {
		-- terminal
		{
			"<leader>fT",
			function()
				Snacks.terminal()
			end,
			desc = "Terminal (cwd)",
		},
		{
			"<leader>ft",
			function()
				Snacks.terminal(nil, { cwd = vim.fn.systemlist("git rev-parse --show-toplevel")[1] })
			end,
			desc = "Terminal (Root Dir)",
		},
		{
			"<c-/>",
			function()
				Snacks.terminal(nil, { cwd = vim.fn.systemlist("git rev-parse --show-toplevel")[1] })
			end,
			mode = { "n", "t" },
			desc = "Terminal (Root Dir)",
		},
		{
			"<c-_>",
			function()
				Snacks.terminal(nil, { cwd = vim.fn.systemlist("git rev-parse --show-toplevel")[1] })
			end,
			mode = { "n", "t" },
			desc = "which_key_ignore",
		},
		-- toggles
		{
			"<leader>n",
			function()
				Snacks.picker.notifications()
			end,
			desc = "Notification History",
		},
		-- ui
		{
			"<leader>ui",
			function()
				vim.show_pos()
			end,
			desc = "Inspect Pos",
		},
		{
			"<leader>uI",
			function()
				vim.treesitter.inspect_tree()
				vim.api.nvim_input("I")
			end,
			desc = "Inspect Tree",
		},
		{
			"<leader>,",
			function()
				Snacks.picker.buffers()
			end,
			desc = "Buffers",
		},
		{
			"<leader>/",
			function()
				Snacks.picker.grep()
			end,
			desc = "Grep (Root Dir)",
		},
		{
			"<leader>:",
			function()
				Snacks.picker.command_history()
			end,
			desc = "Command History",
		},
		{
			"<leader><leader>",
			function()
				Snacks.picker.files()
			end,
			desc = "Find Files (Root Dir)",
		},
		-- find
		{
			"<leader>fb",
			function()
				Snacks.picker.buffers()
			end,
			desc = "Buffers",
		},
		{
			"<leader>ff",
			function()
				Snacks.picker.files()
			end,
			desc = "Find Files (Root Dir)",
		},
		{
			"<leader>fF",
			function()
				Snacks.picker.files({ cwd = vim.fn.getcwd() })
			end,
			desc = "Find Files (cwd)",
		},
		{
			"<leader>fg",
			function()
				Snacks.picker.git_files()
			end,
			desc = "Find Files (git-files)",
		},
		{
			"<leader>fr",
			function()
				Snacks.picker.recent()
			end,
			desc = "Recent",
		},
		-- git
		{
			"<leader>gd",
			function()
				Snacks.picker.git_diff()
			end,
			desc = "Git Diff (hunks)",
		},
		{
			"<leader>gD",
			function()
				Snacks.picker.git_diff({ base = "origin", group = true })
			end,
			desc = "Git Diff (origin)",
		},
		{
			"<leader>gc",
			function()
				Snacks.picker.git_log()
			end,
			desc = "Git Log",
		},
		{
			"<leader>gs",
			function()
				Snacks.picker.git_status()
			end,
			desc = "Git Status",
		},
		-- Grep
		{
			"<leader>sb",
			function()
				Snacks.picker.lines()
			end,
			desc = "Buffer Lines",
		},
		{
			"<leader>sB",
			function()
				Snacks.picker.grep_buffers()
			end,
			desc = "Grep Open Buffers",
		},
		{
			"<leader>sg",
			function()
				Snacks.picker.grep()
			end,
			desc = "Grep (Root Dir)",
		},
		{
			"<leader>sG",
			function()
				Snacks.picker.grep({ cwd = vim.fn.getcwd() })
			end,
			desc = "Grep (cwd)",
		},
		{
			"<leader>sw",
			function()
				Snacks.picker.grep_word()
			end,
			desc = "Visual selection or word (Root Dir)",
			mode = { "n", "x" },
		},
		-- search
		{
			"<leader>sh",
			function()
				Snacks.picker.help()
			end,
			desc = "Help Pages",
		},
		{
			"<leader>sH",
			function()
				Snacks.picker.highlights()
			end,
			desc = "Highlights",
		},
		{
			"<leader>sj",
			function()
				Snacks.picker.jumps()
			end,
			desc = "Jumps",
		},
		{
			"<leader>sk",
			function()
				Snacks.picker.keymaps()
			end,
			desc = "Keymaps",
		},
		{
			"<leader>sm",
			function()
				Snacks.picker.marks()
			end,
			desc = "Marks",
		},
		{
			"<leader>sR",
			function()
				Snacks.picker.resume()
			end,
			desc = "Resume",
		},
		{
			"<leader>sq",
			function()
				Snacks.picker.qflist()
			end,
			desc = "Quickfix List",
		},
		{
			"<leader>sd",
			function()
				Snacks.picker.diagnostics()
			end,
			desc = "Diagnostics",
		},
		{
			"<leader>sD",
			function()
				Snacks.picker.diagnostics_buffer()
			end,
			desc = "Buffer Diagnostics",
		},
		-- ui
		{
			"<leader>uC",
			function()
				Snacks.picker.colorschemes()
			end,
			desc = "Colorschemes",
		},
	},
}
