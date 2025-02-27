return {
    {
        "rebelot/kanagawa.nvim",

        config = function()
            -- Default options:
            require('kanagawa').setup({
                compile = false,
                undercurl = true,
                commentStyle = { italic = true },
                functionStyle = {},
                keywordStyle = { italic = true},
                statementStyle = { bold = true },
                typeStyle = {},
                transparent = false,
                dimInactive = false,
                terminalColors = true,
                colors = {
                    palette = {},
                    theme = { wave = {}, lotus = {}, dragon = {}, all = {} },
                },
                overrides = function(colors)
                    return {}
                end,
                theme = "wave",
                background = {
                    dark = "wave",
                    light = "lotus"
                },
            })

            vim.cmd("colorscheme kanagawa")
        end
    },
    {
        "catppuccin/nvim",
        name = "catppuccin",
        priority = 1000,

        config = function()
            require("catppuccin").setup()

            -- setup must be called before loading
            --vim.cmd.colorscheme "catppuccin"
        end
    },
    {
        "folke/tokyonight.nvim",
        lazy = false,
        priority = 1000,
        opts = {},

        config = function()
            --vim.cmd.colorscheme "tokyonight-night"
        end
    }
}
