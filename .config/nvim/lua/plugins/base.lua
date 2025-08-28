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
        "haskell",
      },
    },
  },

  {
    "saghen/blink.cmp",
    opts = {
      -- keymap = {
      --   preset = "default",
      -- },
      completion = {
        list = { selection = { preselect = false } },
        ghost_text = { enabled = false },
        -- menu = {
        --   border = "rounded",
        --   winhighlight = "Normal:BlinkCmpDoc,FloatBorder:BlinkCmpDocBorder,CursorLine:BlinkCmpDocCursorLine,Search:None",
        --   winblend = 0,
        -- },
        -- documentation = {
        --   window = {
        --     border = "rounded",
        --     winblend = 0,
        --   },
        -- },
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
        layout = { layout = { position = "right" } },
      },
    },
  },

  {
    "neovim/nvim-lspconfig",
    opts = {
      inlay_hints = { enabled = true },
      -- ui = {
      --   windows = {
      --     default_options = {
      --       border = "rounded",
      --     },
      --   },
      -- },
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
