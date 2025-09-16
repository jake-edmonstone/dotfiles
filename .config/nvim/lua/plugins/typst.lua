return {
  {
    "chomosuke/typst-preview.nvim",
    lazy = false, -- or ft = 'typst'
    version = "1.*",
    opts = {
      open_cmd = "open -a 'Orion' %s",
      dependencies_bin = {
        ["tinymist"] = "tinymist",
      },
    }, -- lazy.nvim will implicitly calls `setup {}`
  },

  -- {
  --   "al-kot/typst-preview.nvim",
  --   opts = {
  --     -- your config here
  --   },
  -- },
}
