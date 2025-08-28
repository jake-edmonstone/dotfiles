return {
  {
    "chomosuke/typst-preview.nvim",
    lazy = false, -- or ft = 'typst'
    version = "1.*",
    opts = {
      open_cmd = "qutebrowser %s",
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
