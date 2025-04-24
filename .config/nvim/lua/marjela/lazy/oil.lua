return {
    "stevearc/oil.nvim",
    opts = {},
    lazy = false,
    config = function()
        require("oil").setup({
            columns = {
                { "permissions" },
                { "size" }
            },
            skip_confirm_for_simple_edits = true
        })

        vim.keymap.set("n", "-", function()
            require("oil").open()
        end)
    end
}
