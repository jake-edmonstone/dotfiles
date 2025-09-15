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
    "akinsho/bufferline.nvim",
    highlights = {
      fill = {
        bg = "none", -- transparent
      },
      separator = { bg = "none" },
      separator_visible = { bg = "none" },
      separator_selected = { bg = "none" },
      background = { bg = "none" },
    },
  },

  {
    "saghen/blink.cmp",
    dependencies = {
      { "L3MON4D3/LuaSnip", version = "v2.*" },
    },
    opts = {
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
        list = { selection = { preselect = false } },
        ghost_text = { enabled = false },
      },
      keymap = {
        preset = "default",
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
        sources = { explorer = { layout = { layout = { position = "right" } } } },
        layout = { preset = "default" }, -- centered, large float
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
    config = function()
      require("luasnip.loaders.from_lua").lazy_load({
        paths = vim.fn.stdpath("config") .. "/snippets",
      })
    end,
  },

  {
    "echasnovski/mini.pairs",
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
