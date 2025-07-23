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
    end,
  },

  {
    "nvim-lualine/lualine.nvim",
    opts = {
      options = {
        theme = "dracula-nvim",
      },
    },
  },
}
