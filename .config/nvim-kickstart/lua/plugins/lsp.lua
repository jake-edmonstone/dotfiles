-- LSP Configuration & Plugins
return {
	{
		"folke/lazydev.nvim",
		ft = "lua",
		---@module 'lazydev'
		---@type lazydev.Config
		---@diagnostic disable-next-line: missing-fields
		opts = {
			library = {
				{ path = "${3rd}/luv/library", words = { "vim%.uv" } },
			},
		},
	},
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			{
				"mason-org/mason.nvim",
				---@module 'mason.settings'
				---@type MasonSettings
				---@diagnostic disable-next-line: missing-fields
				opts = {},
			},
			"mason-org/mason-lspconfig.nvim",
			"WhoIsSethDaniel/mason-tool-installer.nvim",
			{ "j-hui/fidget.nvim", opts = {} },
			"saghen/blink.cmp",
		},
		config = function()
			vim.api.nvim_create_autocmd("LspAttach", {
				group = vim.api.nvim_create_augroup("kickstart-lsp-attach", { clear = true }),
				callback = function(event)
					local map = function(keys, func, desc, mode)
						mode = mode or "n"
						vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
					end

					map("grn", vim.lsp.buf.rename, "[R]e[n]ame")
					map("<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction", { "n", "x" })
					map("<leader>cf", function()
						vim.lsp.buf.format({ async = false, timeout_ms = 10000 })
					end, "[C]ode [F]ormat")

					-- LSP navigation with both gr* and g* variants
					map("gd", function()
						Snacks.picker.lsp_definitions()
					end, "Goto Definition")
					map("grd", function()
						Snacks.picker.lsp_definitions()
					end, "[G]oto [D]efinition")
					map("gr", function()
						Snacks.picker.lsp_references()
					end, "References")
					map("grr", function()
						Snacks.picker.lsp_references()
					end, "[G]oto [R]eferences")
					map("gI", function()
						Snacks.picker.lsp_implementations()
					end, "Goto Implementation")
					map("gri", function()
						Snacks.picker.lsp_implementations()
					end, "[G]oto [I]mplementation")
					map("gy", function()
						Snacks.picker.lsp_type_definitions()
					end, "Goto T[y]pe Definition")
					map("grt", function()
						Snacks.picker.lsp_type_definitions()
					end, "[G]oto [T]ype Definition")
					map("grD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")
					map("gO", function()
						Snacks.picker.lsp_symbols()
					end, "Open Document Symbols")
					map("gW", function()
						Snacks.picker.lsp_workspace_symbols()
					end, "Open Workspace Symbols")

					-- diagnostic
					local client = vim.lsp.get_client_by_id(event.data.client_id)
					if
						client
						and client:supports_method(vim.lsp.protocol.Methods.textDocument_documentHighlight, event.buf)
					then
						local highlight_augroup =
							vim.api.nvim_create_augroup("kickstart-lsp-highlight", { clear = false })
						vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
							buffer = event.buf,
							group = highlight_augroup,
							callback = vim.lsp.buf.document_highlight,
						})

						vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
							buffer = event.buf,
							group = highlight_augroup,
							callback = vim.lsp.buf.clear_references,
						})

						vim.api.nvim_create_autocmd("LspDetach", {
							group = vim.api.nvim_create_augroup("kickstart-lsp-detach", { clear = true }),
							callback = function(event2)
								vim.lsp.buf.clear_references()
								vim.api.nvim_clear_autocmds({ group = "kickstart-lsp-highlight", buffer = event2.buf })
							end,
						})
					end

					if
						client and client:supports_method(vim.lsp.protocol.Methods.textDocument_inlayHint, event.buf)
					then
						map("<leader>th", function()
							vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = event.buf }))
						end, "[T]oggle Inlay [H]ints")
					end
				end,
			})

			vim.diagnostic.config({
				severity_sort = true,
				float = { border = "rounded", source = "if_many" },
				signs = vim.g.have_nerd_font and {
					text = {
						[vim.diagnostic.severity.ERROR] = "󰅚 ",
						[vim.diagnostic.severity.WARN] = "󰀪 ",
						[vim.diagnostic.severity.INFO] = "󰋽 ",
						[vim.diagnostic.severity.HINT] = "󰌶 ",
					},
				} or {},
				virtual_text = {
					source = "if_many",
					spacing = 2,
				},
			})

			---@class LspServersConfig
			---@field mason table<string, vim.lsp.Config>
			---@field others table<string, vim.lsp.Config>
			local servers = {
				mason = {
					lua_ls = {
						settings = {
							Lua = {
								completion = {
									callSnippet = "Replace",
								},
								workspace = {
									library = {
										vim.env.VIMRUNTIME,
									},
								},
							},
						},
					},
				},
				others = {},
			}

			local ensure_installed = vim.tbl_keys(servers.mason or {})
			vim.list_extend(ensure_installed, {
				"stylua",
			})
			require("mason-tool-installer").setup({ ensure_installed = ensure_installed })

			for server, config in pairs(vim.tbl_extend("keep", servers.mason, servers.others)) do
				if not vim.tbl_isempty(config) then
					vim.lsp.config(server, config)
				end
			end

			require("mason-lspconfig").setup({
				ensure_installed = {},
				automatic_enable = true,
			})

			if not vim.tbl_isempty(servers.others) then
				vim.lsp.enable(vim.tbl_keys(servers.others))
			end
		end,
	},

	-- Autoformat
	{
		"stevearc/conform.nvim",
		event = { "BufWritePre" },
		cmd = { "ConformInfo" },
		keys = {
			{
				"<leader>f",
				function()
					require("conform").format({ async = true, lsp_format = "fallback" })
				end,
				mode = "",
				desc = "[F]ormat buffer",
			},
		},
		---@module 'conform'
		---@type conform.setupOpts
		opts = {
			notify_on_error = false,
			format_on_save = function(bufnr)
				local disable_filetypes = { c = true, cpp = true }
				if disable_filetypes[vim.bo[bufnr].filetype] then
					return nil
				else
					return {
						timeout_ms = 500,
						lsp_format = "fallback",
					}
				end
			end,
			formatters_by_ft = {
				lua = { "stylua" },
			},
		},
	},
}
