return {
    "akinsho/nvim-bufferline.lua",

    config = function()
        require("bufferline").setup({
            options = {
                numbers = "ordinal",
                indicator = {
                    icon = '▎',
                    style = "icon"
                },
                custom_filter = function(buf_number, buf_numbers)
                    local buftype = vim.bo[buf_number].buftype
                    if buftype == "quickfix" then
                        return false
                    end
                    if buftype == "terminal" then
                        return false
                    end
                    return true
                end
            },

            highlights = {
               fill = {
                   bg = '#1a1a1c'
               },
            --    buffer_selected = {
            --        fg = '#a5a8bb',
            --        bg = '#2a2a37',
            --        bold = true,
            --        italic = true,
            --    },
            --    numbers_selected = {
            --        fg = '#a5a8bb',
            --        bg = '#2a2a37',
            --        bold = true,
            --        italic = true,
            --    },
            --    buffer_visible = {
            --        fg = '#54546d',
            --        bg = '#1f1f28',
            --    },
            --    numbers_visible = {
            --        fg = '#54546d',
            --        bg = '#1f1f28'
            --    },
            --    numbers = {
            --        fg = '#54546d',
            --        bg = '#1f1f28'
            --    },
            --    separator = {
            --        fg = '#1f1f28',
            --        bg = '#1f1f28'
            --    },
            --    modified = {
            --        fg = '#54546d',
            --        bg = '#1f1f28'
            --    },
            --    modified_visible = {
            --        fg = '#54546d',
            --        bg = '#1f1f28'
            --    },
            --    modified_selected = {
            --        fg = '#54546d',
            --        bg = '#2a2a37'
            --    },
            --    indicator_selected = {
            --        fg = '#54546d',
            --        bg = '#54546d',
            --    },
            --    indicator_visible = {
            --        fg = '#54546d',
            --        bg = '#54546d',
            --    },
            --    close_button = {
            --        fg = '#54546d',
            --        bg = '#1f1f28'
            --    },
            --    close_button_visible = {
            --        fg = '#54546d',
            --        bg = '#1f1f28'
            --    },
            --    close_button_selected = {
            --        fg = '#54546d',
            --        bg = '#2a2a37'
            --    },
            --    fill = {
            --        fg = '#54546d',
            --        bg = '#1f1f28'
            --    },
            }
        })

        local opts = { noremap = true, silent = true }

        vim.api.nvim_set_keymap('n', '<leader>n', ':BufferLineCycleNext<CR>', opts)
        vim.api.nvim_set_keymap('n', '<leader>b', ':BufferLineCyclePrev<CR>', opts)

        vim.api.nvim_set_keymap('n', '<leader>1', ':BufferLineGoToBuffer 1<CR>', opts)
        vim.api.nvim_set_keymap('n', '<leader>2', ':BufferLineGoToBuffer 2<CR>', opts)
        vim.api.nvim_set_keymap('n', '<leader>3', ':BufferLineGoToBuffer 3<CR>', opts)
        vim.api.nvim_set_keymap('n', '<leader>4', ':BufferLineGoToBuffer 4<CR>', opts)
        vim.api.nvim_set_keymap('n', '<leader>5', ':BufferLineGoToBuffer 5<CR>', opts)
        vim.api.nvim_set_keymap('n', '<leader>6', ':BufferLineGoToBuffer 6<CR>', opts)
        vim.api.nvim_set_keymap('n', '<leader>7', ':BufferLineGoToBuffer 7<CR>', opts)
        vim.api.nvim_set_keymap('n', '<leader>8', ':BufferLineGoToBuffer 8<CR>', opts)
        vim.api.nvim_set_keymap('n', '<leader>9', ':BufferLineGoToBuffer 9<CR>', opts)
        vim.api.nvim_set_keymap('n', '<leader>0', ':BufferLineGoToBuffer 10<CR>', opts)
    end
}
