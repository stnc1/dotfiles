return {
    'stevearc/oil.nvim',
    opts = {},
    lazy = false,
    config = function()
        require("oil").setup({
            columns = {
                { "type" },
                { "permissions", highlight = "Special" },
                { 'size', highlight = "DiagnosticError" }
            },
            skip_confirm_for_simple_edits = true
        })

        vim.keymap.set("n", "-", function()
            require("oil").open()
        end)
    end
}
