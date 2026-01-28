local bg = "NONE" --"#282A36"
local yellow = "#F1FA8C"
local green = "#50fa7b"
local purple = "#BD93F9"
local cyan = "#8BE9FD"
local pink = "#FF79C6"
local visual = "#3E4452"
local white = "#ABB2BF"
local black = "#191A21"
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

  {
    "nvim-lualine/lualine.nvim",
    opts = {
      options = {
        component_separators = { left = "│", right = "│" },
        section_separators = "", --{ left = '', right = ''},
        --theme = "dracula-nvim",
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
      },
    },
  },
}
