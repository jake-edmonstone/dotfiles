return {
  {
    "lervag/vimtex",
    lazy = false,     -- we don't want to lazy load VimTeX
    -- tag = "v2.15", -- uncomment to pin to a specific release
    config = function()
      vim.g.vimtex_view_method = 'skim'
      vim.g.vimtex_view_skim_sync = 1
      vim.g.vimtex_clean_dirs = { '/Users/jbedm/Latex/Aux/' }
      vim.g.vimtex_clean_files = { '/Users/jbedm/Latex/Aux/*.synctex.gz' }
      vim.g.vimtex_view_skim_activate = 1
      vim.g.vimtex_quickfix_mode = 0
      vim.g.vimtex_fold_enabled = 1
      vim.g.vimtex_compiler_latexmk = {
        build_dir = '/Users/jbedm/Latex/Aux/',
        callback = 1,
        continuous = 1,
        executable = 'latexmk',
        options = {
          '-pdf',
          '-pdflatex=xelatex -interaction=nonstopmode -synctex=1',
        },
      }
    end
  }
}
