return {
    {
        "folke/flash.nvim",
        event = "VeryLazy",
        opts = {
            modes = {
                char = { -- disable fFtT enhansed motions
                    enabled = false
                }
            }
        },
        keys = {
            { "s",     mode = { "n", "x", "o" }, function() require("flash").jump() end,              desc = "Flash" },
            --{ "S", mode = { "n", "x", "o" }, function() require("flash").treesitter() end, desc = "Flash Treesitter" },
            { "r",     mode = "o",               function() require("flash").remote() end,            desc = "Remote Flash" },
            { "R",     mode = { "o", "x" },      function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
            { "<c-s>", mode = { "c" },           function() require("flash").toggle() end,            desc = "Toggle Flash Search" },
        },
    },
    {
        "jinh0/eyeliner.nvim",
        config = function()
            require("eyeliner").setup({
                highlight_on_key = true,
                dim = true
            })
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
