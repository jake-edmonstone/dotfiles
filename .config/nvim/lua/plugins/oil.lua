return {
  "stevearc/oil.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  cmd = { "Oil" }, -- keep lazy-loading by command
  keys = {
    {
      "<leader>o",
      function()
        local oil = require("oil")
        local bufnr = vim.api.nvim_get_current_buf()
        if vim.bo[bufnr].filetype == "oil" then
          vim.cmd("q") -- close if already in Oil
        else
          oil.open_float()
        end
      end,
      desc = "Toggle Oil",
    },
  },
  opts = {
    view_options = { show_hidden = true },
    float = { padding = 5 },
  },
  init = function()
    -- Open Oil automatically when starting with a single directory arg, e.g. `nvim .`
    if vim.fn.argc() ~= 1 then
      return
    end
    local a = vim.fn.argv(0)
    if type(a) ~= "string" or vim.fn.isdirectory(a) ~= 1 then
      return
    end
    vim.api.nvim_create_autocmd("VimEnter", {
      once = true,
      callback = function()
        -- ensure plugin is loaded before using it
        pcall(function()
          require("lazy").load({ plugins = { "oil.nvim" } })
        end)
        local ok, oil = pcall(require, "oil")
        if ok then
          oil.open(a)
        end
      end,
    })
  end,
  config = function(_, opts)
    require("oil").setup(opts)
  end,
}
