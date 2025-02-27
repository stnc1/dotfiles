return {
    'stevearc/oil.nvim',
    opts = {},
    lazy = false,
    config = function()
        require("oil").setup({
            columns = {
                { "type", highlight = "Directory" },
                { "permissions", highlight = "Special" },
                { 'size', highlight = "DiagnosticError" }
            }
        })

        vim.keymap.set("n", "-", function()
            require("oil").open()
        end)
    end
}
