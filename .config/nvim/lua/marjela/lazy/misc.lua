return {
    { -- automatically makes pairs for (,{,[,",',` etc.
        "echasnovski/mini.pairs",
        version = false,
        config = function()
            require("mini.pairs").setup()
        end
    },
    {
        "brenoprata10/nvim-highlight-colors",
        config = function()
            require("nvim-highlight-colors").setup()
        end
    },
    { -- auto commenting
        "tpope/vim-commentary"
    },
    {
        "tpope/vim-repeat"
    }
}
