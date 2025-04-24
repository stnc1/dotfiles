return {
    {
        "jinh0/eyeliner.nvim",
        config = function()
            require("eyeliner").setup({
                highlight_on_key = true,
                dim = true
            })

            vim.api.nvim_set_hl(0, 'EyelinerPrimary', { fg='#ffffff', bold = true, underline = true })
            vim.api.nvim_set_hl(0, 'EyelinerSecondary', { fg='#999999', underline = true })
        end
    },
    {
        "tpope/vim-surround"
    },
    { -- provides several text-objects, and allows to create your own
        "echasnovski/mini.ai",
        version = false,
        config = function()
            require("mini.ai").setup()
        end
    }
}
