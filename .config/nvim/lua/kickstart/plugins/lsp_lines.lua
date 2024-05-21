return {
  {
    'https://git.sr.ht/~whynothugo/lsp_lines.nvim',
    config = function()
      require('lsp_lines').setup()
      local function toggle_lsp_lines_and_virtual_text()
            -- Toggle lsp_lines
    require('lsp_lines').toggle()

    -- Toggle virtualtext
    local current_virtualtext = vim.diagnostic.config().virtual_text
    vim.diagnostic.config({
        virtual_text = not current_virtualtext,
    })
        
      end
      vim.diagnostic.config {
        virtual_lines = false,
        vim.keymap.set('n', '<c-e>', toggle_lsp_lines_and_virtual_text, { desc = 'Toggle lsp_lines' }),
      }
    end,
  },
}
