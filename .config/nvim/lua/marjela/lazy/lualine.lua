local function buffer_name()
    local bufname = vim.api.nvim_buf_get_name(0)
    if bufname:match("^oil://") then
        return bufname:gsub("^oil://", "")
    end
    return vim.fn.fnamemodify(bufname, ":~:.")
end

return {
    {
        "nvim-lualine/lualine.nvim",

        config = function()
            require("lualine").setup({
                options = {
                    icons_enabled = false,
                    component_separators = '',
                    section_separators = '',
                    globalstatus = false
                },

                sections = {
                    lualine_a = { 'mode' },
                    lualine_b = { 'branch' },
                    lualine_c = { buffer_name },
                    lualine_x = {
                        {
                            'buffers',
                            symbols = {
                                modified = '+',      -- Text to show when the buffer is modified
                                alternate_file = '', -- Text to show to identify the alternate file
                            },
                            buffers_color = {
                                -- Same values as the general color option can be used here.
                                -- active = 'lualine_buffers_normal',     -- Color for active buffer.
                                active = 'lualine_buffers_inactive', -- Color for inactive buffer.
                            },
                        }
                    },
                    lualine_y = { 'filesize', 'encoding' },
                    lualine_z = { 'location' },
                }
            })
        end
    }
}
