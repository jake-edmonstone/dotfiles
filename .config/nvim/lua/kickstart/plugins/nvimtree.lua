-- You can add your own plugins here or in other files in this directory!
--  I promise not to create any merge conflicts in this directory :)
--
-- See the kickstart.nvim README for more information

function My_on_attach(bufnr)
    local api = require 'nvim-tree.api'

    local function opts(desc)
        return { desc = 'nvim-tree: ' .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
    end

    -- default mappings
    api.config.mappings.default_on_attach(bufnr)

    -- custom mappings
    vim.keymap.set('n', 'w', require('nvim-tree.api').tree.change_root_to_node, opts('cd'))
end

return {
    'nvim-tree/nvim-tree.lua',
    version = '*',
    lazy = false,
    dependencies = {
        'nvim-tree/nvim-web-devicons',
    },
    config = function()
        require('nvim-tree').setup { on_attach = My_on_attach }

        function OpenNvimTreeIfNoFiles()
            -- Check if Neovim is started without any arguments.
            if #vim.fn.argv() == 0 then
                -- Open NvimTree.
                vim.cmd 'NvimTreeOpen'
            end
        end

        -- Call the function on VimEnter event.
        vim.cmd 'autocmd VimEnter * lua OpenNvimTreeIfNoFiles()'
    end,
}
