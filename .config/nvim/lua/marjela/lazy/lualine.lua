return {
    'nvim-lualine/lualine.nvim',

    config = function()
        require("lualine").setup {
            options = {
                theme = "onedark",
                icons_enabled = false,
                component_separators = '',
                section_separators = '',
                globalstatus = false
            },

            sections = {
                lualine_a = { 'mode' },
                lualine_b = { 'branch' },
                lualine_c = { 'filename' },
                lualine_x = {  },
                lualine_y = { 'filesize', 'encoding' },
                lualine_z = { 'location' },
            }
        }
    end
}
