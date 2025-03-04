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
    },
    {
        "chrishrb/gx.nvim",
        keys = { { "gx", "<cmd>Browse<cr>", mode = { "n", "x" } } },
        cmd = { "Browse" },
        init = function ()
            vim.g.netrw_nogx = 1 -- disable netrw gx
        end,
        config = function() require("gx").setup({
            handlers = {
                github = false,
                brewfile = false,
                package_json = false,
                jira = false,
                rust = false
            },
            handler_options = {
                search_engine = "https://search.brave.com/search?q="
            }
        })
        end
    }
}
