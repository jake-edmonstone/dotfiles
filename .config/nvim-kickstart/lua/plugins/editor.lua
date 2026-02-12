-- Basic editor enhancements
return {
	-- Detect tabstop and shiftwidth automatically
	{ "NMAC427/guess-indent.nvim", opts = {} },

	-- Adds git related signs to the gutter
	{
		"lewis6991/gitsigns.nvim",
		event = { "BufReadPre", "BufNewFile" },
		opts = {
			signs = {
				add = { text = "▎" },
				change = { text = "▎" },
				delete = { text = "" },
				topdelete = { text = "" },
				changedelete = { text = "▎" },
				untracked = { text = "▎" },
			},
			signs_staged = {
				add = { text = "▎" },
				change = { text = "▎" },
				delete = { text = "" },
				topdelete = { text = "" },
				changedelete = { text = "▎" },
			},
			on_attach = function(buffer)
				local gs = package.loaded.gitsigns

				local function map(mode, l, r, desc)
					vim.keymap.set(mode, l, r, { buffer = buffer, desc = desc, silent = true })
				end

				-- stylua: ignore start
				map("n", "]h", function()
					if vim.wo.diff then
						vim.cmd.normal({ "]c", bang = true })
					else
						gs.nav_hunk("next")
					end
				end, "Next Hunk")
				map("n", "[h", function()
					if vim.wo.diff then
						vim.cmd.normal({ "[c", bang = true })
					else
						gs.nav_hunk("prev")
					end
				end, "Prev Hunk")
				map("n", "]H", function() gs.nav_hunk("last") end, "Last Hunk")
				map("n", "[H", function() gs.nav_hunk("first") end, "First Hunk")
				map({ "n", "x" }, "<leader>ghs", ":Gitsigns stage_hunk<CR>", "Stage Hunk")
				map({ "n", "x" }, "<leader>ghr", ":Gitsigns reset_hunk<CR>", "Reset Hunk")
				map("n", "<leader>ghS", gs.stage_buffer, "Stage Buffer")
				map("n", "<leader>ghu", gs.undo_stage_hunk, "Undo Stage Hunk")
				map("n", "<leader>ghR", gs.reset_buffer, "Reset Buffer")
				map("n", "<leader>ghp", gs.preview_hunk_inline, "Preview Hunk Inline")
				map("n", "<leader>ghb", function() gs.blame_line({ full = true }) end, "Blame Line")
				map("n", "<leader>ghB", function() gs.blame() end, "Blame Buffer")
				map("n", "<leader>ghd", gs.diffthis, "Diff This")
				map("n", "<leader>ghD", function() gs.diffthis("~") end, "Diff This ~")
				map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>", "GitSigns Select Hunk")
				-- stylua: ignore end
			end,
		},
	},

	-- Highlight todo, notes, etc in comments
	{
		"folke/todo-comments.nvim",
		event = "VimEnter",
		dependencies = { "nvim-lua/plenary.nvim" },
		---@module 'todo-comments'
		---@type TodoOptions
		---@diagnostic disable-next-line: missing-fields
		opts = { signs = false },
	},

	-- Collection of various small independent plugins/modules
	{
		"nvim-mini/mini.nvim",
		config = function()
			-- Better Around/Inside textobjects
			require("mini.ai").setup({ n_lines = 500 })
			-- Add/delete/replace surroundings (brackets, quotes, etc.)
			require("mini.surround").setup()
		end,
	},

	-- mini.diff - Git diff visualization
	{
		"nvim-mini/mini.diff",
		event = "VeryLazy",
		keys = {
			{
				"<leader>go",
				function()
					require("mini.diff").toggle_overlay(0)
				end,
				desc = "Toggle mini.diff overlay",
			},
		},
		opts = {
			view = {
				style = "sign",
				signs = {
					add = "▎",
					change = "▎",
					delete = "",
				},
			},
		},
	},

	-- Auto-pairs for typst
	{
		"nvim-mini/mini.pairs",
		ft = "typst",
		opts = {},
		config = function(_, opts)
			local mp = require("mini.pairs")
			mp.setup(opts)
			vim.api.nvim_create_autocmd("FileType", {
				pattern = "typst",
				callback = function(ev)
					mp.map_buf(ev.buf, "i", "$", {
						action = "closeopen",
						pair = "$$",
						neigh_pattern = "[^\\].",
						register = { cr = true },
					})
				end,
			})
		end,
	},

	-- Treesitter textobjects for better navigation
	{
		"nvim-treesitter/nvim-treesitter-textobjects",
		event = "VeryLazy",
		config = function()
			local move = {
				goto_next_start = {
					["]f"] = "@function.outer",
					["]c"] = "@class.outer",
					["]a"] = "@parameter.inner",
				},
				goto_next_end = {
					["]F"] = "@function.outer",
					["]C"] = "@class.outer",
					["]A"] = "@parameter.inner",
				},
				goto_previous_start = {
					["[f"] = "@function.outer",
					["[c"] = "@class.outer",
					["[a"] = "@parameter.inner",
				},
				goto_previous_end = {
					["[F"] = "@function.outer",
					["[C"] = "@class.outer",
					["[A"] = "@parameter.inner",
				},
			}

			-- Set up keymaps for each buffer
			local function setup_keymaps(bufnr)
				for direction, keymaps in pairs(move) do
					for key, query in pairs(keymaps) do
						local method = direction
						local desc = ""

						-- Build description
						local obj = query:gsub("@", ""):gsub("%..*", "")
						obj = obj:sub(1, 1):upper() .. obj:sub(2)

						if key:sub(1, 1) == "]" then
							desc = "Next " .. obj
						else
							desc = "Prev " .. obj
						end

						if key:sub(2, 2) == key:sub(2, 2):upper() then
							desc = desc .. " End"
						else
							desc = desc .. " Start"
						end

						-- Skip conflict with diff mode [c/]c
						if not (vim.wo.diff and key:find("[cC]")) then
							vim.keymap.set({ "n", "x", "o" }, key, function()
								require("nvim-treesitter.textobjects.move")[method](query)
							end, {
								buffer = bufnr,
								desc = desc,
								silent = true,
							})
						end
					end
				end
			end

			-- Setup for all current buffers
			for _, buf in ipairs(vim.api.nvim_list_bufs()) do
				if vim.api.nvim_buf_is_loaded(buf) then
					setup_keymaps(buf)
				end
			end

			-- Setup for new buffers
			vim.api.nvim_create_autocmd("FileType", {
				group = vim.api.nvim_create_augroup("treesitter_textobjects", { clear = true }),
				callback = function(ev)
					setup_keymaps(ev.buf)
				end,
			})
		end,
	},

	-- Treesitter for syntax highlighting
	{
		"nvim-treesitter/nvim-treesitter",
		lazy = false,
		build = ":TSUpdate",
		config = function()
			require("nvim-treesitter").install({
				"bash",
				"c",
				"cpp",
				"html",
				"javascript",
				"json",
				"lua",
				"markdown",
				"markdown_inline",
				"python",
				"query",
				"regex",
				"tsx",
				"typescript",
				"vim",
				"vimdoc",
				"yaml",
				"typst",
				"haskell",
				"go",
				"java",
			})

			vim.api.nvim_create_autocmd("FileType", {
				pattern = { "c", "lua", "javascript", "typescript", "python", "go", "java" },
				callback = function()
					vim.treesitter.start()
				end,
			})
		end,
	},

	-- Auto-close and auto-rename HTML tags
	{
		"windwp/nvim-ts-autotag",
		event = { "BufReadPost", "BufNewFile" },
		opts = {},
	},

	-- Show code context (sticky header)
	{
		"nvim-treesitter/nvim-treesitter-context",
		event = { "BufReadPost", "BufNewFile" },
		opts = function()
			local tsc = require("treesitter-context")
			Snacks.toggle({
				name = "Treesitter Context",
				get = tsc.enabled,
				set = function(state)
					if state then
						tsc.enable()
					else
						tsc.disable()
					end
				end,
			}):map("<leader>ut")
			return { mode = "cursor", max_lines = 3 }
		end,
	},
}
