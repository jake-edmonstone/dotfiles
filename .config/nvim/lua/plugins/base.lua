-- every spec file under the "plugins" directory will be loaded automatically by lazy.nvim
--
-- In your plugin files, you can:
-- * add extra plugins
-- * disable/enabled LazyVim plugins
-- * override the configuration of LazyVim plugins
return {
  -- add more treesitter parsers
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        "bash",
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
        "yaml",
        "typst",
      },
    },
  },

  {
    "saghen/blink.cmp",
    opts = {
      completion = {
        ghost_text = { enabled = false },
      },
    },
  },

  { "folke/snacks.nvim", opts = {
    picker = {
      layout = { layout = { position = "right" } },
    },
  } },

  {
    "neovim/nvim-lspconfig",
    ---@class PluginLspOpts
    opts = {
      ---@type lspconfig.options
      servers = {
        tinymist = {
          settings = {
            root_dir = "--",
            formatterMode = "typestyle",
            -- exportPdf = "never",
          },
        },
      },
    },
  },

  {
    "nvim-lspconfig",
    opts = {
      inlay_hints = { enabled = false },
    },
  },

  {
    "echasnovski/mini.snippets",
    opts = function()
      local gen_loader = require("mini.snippets").gen_loader
      return {
        snippets = {
          gen_loader.from_file("~/.config/nvim/snippets/global.json"),
          gen_loader.from_lang(),
        },
      }
    end,
  },
}
