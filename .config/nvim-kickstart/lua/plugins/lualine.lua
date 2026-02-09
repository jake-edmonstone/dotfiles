return {
	"nvim-lualine/lualine.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	opts = function()
		-- PERF: we don't need this lualine require madness 🤷
		local lualine_require = require("lualine_require")
		lualine_require.require = require

		-- Define colors for custom theme
		local bg = "NONE"
		local yellow = "#F1FA8C"
		local green = "#50fa7b"
		local purple = "#BD93F9"
		local cyan = "#8BE9FD"
		local pink = "#FF79C6"
		local visual = "#3E4452"
		local white = "#ABB2BF"
		local black = "#191A21"

		-- Define icons
		local icons = {
			diagnostics = {
				Error = " ",
				Warn = " ",
				Info = " ",
				Hint = " ",
			},
			git = {
				added = " ",
				modified = " ",
				removed = " ",
			},
		}

		vim.o.laststatus = vim.g.lualine_laststatus or 3

		-- Helper function to get root directory
		local function root_dir()
			local cwd = vim.fn.getcwd()
			return {
				function()
					return vim.fn.fnamemodify(cwd, ":~")
				end,
			}
		end

		-- Helper function for pretty path
		local function pretty_path()
			return {
				"filename",
				path = 1, -- 0 = just filename, 1 = relative path, 2 = absolute path
			}
		end

		-- Helper to check if package is loaded
		local function has_plugin(plugin)
			return package.loaded[plugin] ~= nil
		end

		local opts = {
			options = {
				component_separators = { left = "│", right = "│" },
				section_separators = "",
				theme = {
					normal = {
						a = { fg = black, bg = purple, gui = "bold" },
						b = { fg = purple, bg = bg },
						c = { fg = white, bg = bg },
					},
					command = {
						a = { fg = black, bg = cyan, gui = "bold" },
						b = { fg = cyan, bg = bg },
					},
					visual = {
						a = { fg = black, bg = pink, gui = "bold" },
						b = { fg = pink, bg = bg },
					},
					inactive = {
						a = { fg = white, bg = visual, gui = "bold" },
						b = { fg = black, bg = white },
					},
					replace = {
						a = { fg = black, bg = yellow, gui = "bold" },
						b = { fg = yellow, bg = bg },
						c = { fg = white, bg = bg },
					},
					insert = {
						a = { fg = black, bg = green, gui = "bold" },
						b = { fg = green, bg = bg },
						c = { fg = white, bg = bg },
					},
				},
				globalstatus = vim.o.laststatus == 3,
				disabled_filetypes = { statusline = { "dashboard", "alpha", "ministarter", "snacks_dashboard" } },
			},
			sections = {
				lualine_a = { "mode" },
				lualine_b = { "branch" },

				lualine_c = {
					root_dir(),
					{
						"diagnostics",
						symbols = {
							error = icons.diagnostics.Error,
							warn = icons.diagnostics.Warn,
							info = icons.diagnostics.Info,
							hint = icons.diagnostics.Hint,
						},
					},
					{ "filetype", icon_only = true, separator = "", padding = { left = 1, right = 0 } },
					pretty_path(),
				},
				lualine_x = {
					-- stylua: ignore
					{
						function() return require("noice").api.status.command.get() end,
						cond = function() return has_plugin("noice") and require("noice").api.status.command.has() end,
						color = function() return { fg = Snacks.util.color("Statement") } end,
					},
					-- stylua: ignore
					{
						function() return require("noice").api.status.mode.get() end,
						cond = function() return has_plugin("noice") and require("noice").api.status.mode.has() end,
						color = function() return { fg = Snacks.util.color("Constant") } end,
					},
					-- stylua: ignore
					{
						function() return "  " .. require("dap").status() end,
						cond = function() return has_plugin("dap") and require("dap").status() ~= "" end,
						color = function() return { fg = Snacks.util.color("Debug") } end,
					},
					-- stylua: ignore
					{
						require("lazy.status").updates,
						cond = require("lazy.status").has_updates,
						color = function() return { fg = Snacks.util.color("Special") } end,
					},
					{
						"diff",
						symbols = {
							added = icons.git.added,
							modified = icons.git.modified,
							removed = icons.git.removed,
						},
						source = function()
							local gitsigns = vim.b.gitsigns_status_dict
							if gitsigns then
								return {
									added = gitsigns.added,
									modified = gitsigns.changed,
									removed = gitsigns.removed,
								}
							end
						end,
					},
				},
				lualine_y = {
					{ "progress", separator = " ", padding = { left = 1, right = 0 } },
					{ "location", padding = { left = 0, right = 1 } },
				},
				lualine_z = {},
			},
			extensions = { "lazy", "trouble" },
		}

		-- Add trouble symbols if available
		if vim.g.trouble_lualine and has_plugin("trouble") then
			local trouble = require("trouble")
			local symbols = trouble.statusline({
				mode = "symbols",
				groups = {},
				title = false,
				filter = { range = true },
				format = "{kind_icon}{symbol.name:Normal}",
				hl_group = "lualine_c_normal",
			})
			table.insert(opts.sections.lualine_c, {
				symbols and symbols.get,
				cond = function()
					return vim.b.trouble_lualine ~= false and symbols.has()
				end,
			})
		end

		return opts
	end,
}
