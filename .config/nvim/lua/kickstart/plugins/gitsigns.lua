-- Here is a more advanced example where we pass configuration
-- options to `gitsigns.nvim`. This is equivalent to the following lua:
--    require('gitsigns').setup({ ... })
--
-- See `:help gitsigns` to understand what the configuration keys do
return {
  { -- Adds git related signs to the gutter, as well as utilities for managing changes
    'lewis6991/gitsigns.nvim',
    opts = {
      on_attach = function(bufnr)
        local gs = package.loaded.gitsigns

        local function map(mode, l, r, opts)
          opts = opts or {}
          opts.buffer = bufnr
          vim.keymap.set(mode, l, r, opts)
        end

        -- Navigation
        map('n', ']c', function()
          if vim.wo.diff then return ']c' end
          vim.schedule(function() gs.next_hunk() end)
          return '<Ignore>'
        end, {expr=true})

        map('n', '[c', function()
          if vim.wo.diff then return '[c' end
          vim.schedule(function() gs.prev_hunk() end)
          return '<Ignore>'
        end, {expr=true})

        -- Actions
        map('n', '<leader>gs', gs.stage_hunk, {desc = "git stage hunk"})
        map('v', '<leader>gs', function() gs.stage_hunk {vim.fn.line('.'), vim.fn.line('v')} end, {desc = "git stage hunk"})
        map('n', '<leader>gr', gs.reset_hunk, {desc = "git reset hunk"})
        map('v', '<leader>gr', function() gs.reset_hunk {vim.fn.line('.'), vim.fn.line('v')} end, {desc = "git reset hunk"})
        map('n', '<leader>gS', gs.stage_buffer, {desc = "git stage buffer"})
        map('n', '<leader>gu', gs.undo_stage_hunk, {desc = "git undo stage hunk"})
        map('n', '<leader>gR', gs.reset_buffer, {desc = "git reset buffer"})
        map('n', '<leader>gp', gs.preview_hunk, {desc = "git preview hunk"})
        map('n', '<leader>gb', gs.toggle_current_line_blame, {desc = "git current line blame"})
        map('n', '<leader>gd', gs.diffthis, {desc = "git diff"} )
        map('n', '<leader>gD', function() gs.diffthis('~') end, {desc = "git diff ~"})

        -- Text object
        map({'o', 'x'}, 'ih', ':<C-U>Gitsigns select_hunk<CR>')
      end
    },
  },
}
-- vim: ts=2 sts=2 sw=2 et
