return {
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
        "haskell",
      },
    },
  },

  {
    "saghen/blink.cmp",
    dependencies = {
      { "L3MON4D3/LuaSnip", version = "v2.*" },
    },
    opts = {
      cmdline = { enabled = false },
      snippets = { preset = "luasnip" },
      sources = {
        default = {
          "lsp",
          "path",
          "snippets",
          "buffer",
        },
      },
      completion = {
        list = { selection = { preselect = false, auto_insert = false } },
        ghost_text = { enabled = false },
      },
      keymap = {
        preset = "enter",
        ["<Tab>"] = {
          function(cmp)
            return cmp.accept({ index = 1 })
          end,
          "fallback",
        },
      },
    },
  },

  {
    "folke/noice.nvim",
    opts = {
      presets = {
        lsp_doc_border = true,
      },
    },
  },

  {
    "folke/snacks.nvim",
    opts = {
      explorer = { enabled = false },
      picker = {
        sources = {
          files = { hidden = true },
          explorer = { layout = { layout = { position = "right" } } },
        },
        layout = { preset = "default" }, -- centered, large float
        hidden = true,
      },
    },
  },

  {
    "neovim/nvim-lspconfig",
    opts = {
      inlay_hints = { enabled = true },
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
    "L3MON4D3/LuaSnip",
    lazy = true,
    config = function()
      require("luasnip.loaders.from_lua").lazy_load({
        paths = { vim.fn.stdpath("config") .. "/snippets" },
      })
    end,
  },

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
}
