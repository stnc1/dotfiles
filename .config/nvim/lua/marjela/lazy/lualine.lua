local function buffer_name()
    local bufname = vim.api.nvim_buf_get_name(0)
    if bufname:match("^oil://") then
        -- Показываем путь oil буфера
        return bufname:gsub("^oil://", "")
    end
    -- В остальных случаях показываем обычное имя файла
    return vim.fn.fnamemodify(bufname, ":~:.")
end

return {
    "nvim-lualine/lualine.nvim",

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
                lualine_c = { buffer_name },
                lualine_x = {},
                lualine_y = { 'filesize', 'encoding' },
                lualine_z = { 'location' },
            }
        }
    end
}
