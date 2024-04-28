return {
  { -- Collection of various small independent plugins/modules
    'echasnovski/mini.nvim',
    config = function()
      -- Better Around/Inside textobjects
      --
      -- Examples:
      --  - va)  - [V]isually select [A]round [)]paren
      --  - yinq - [Y]ank [I]nside [N]ext [']quote
      --  - ci'  - [C]hange [I]nside [']quote
      require('mini.ai').setup { n_lines = 500 }

      -- Add/delete/replace surroundings (brackets, quotes, etc.)
      --
      -- - saiw) - [S]urround [A]dd [I]nner [W]ord [)]Paren
      -- - sd'   - [S]urround [D]elete [']quotes
      -- - sr)'  - [S]urround [R]eplace [)] [']
      require('mini.surround').setup()

      require('mini.starter').setup()
      require('mini.sessions').setup()

      -- Define a function to save a session
      function SaveSession(sessionName)
        require('mini.sessions').write(sessionName)
      end

      -- Define a function to select a session
      function SelectSession()
        require('mini.sessions').select()
      end
      -- Command to save a session with a specified name
      vim.api.nvim_create_user_command('SaveSession', function(input)
        SaveSession(input.args)
      end, { nargs = 1 })

      -- Command to select a session
      vim.api.nvim_create_user_command('SelectSession', SelectSession, {})
    end,
  },
}
-- vim: ts=2 sts=2 sw=2 et
