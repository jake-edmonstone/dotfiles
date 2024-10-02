return {
  {
    'nvim-treesitter/nvim-treesitter-context',
    config = function ()
      require'treesitter-context'.setup{
        max_lines = 6, -- How many lines the window should span. Values <= 0 mean no limit.
        min_window_height = 0, -- Minimum editor window height to enable context. Values <= 0 mean no limit.
        multiline_threshold = 6, -- Maximum number of lines to show for a single context
      }
      vim.cmd('hi TreesitterContext guibg=#2E3440')
    end
  }
}
