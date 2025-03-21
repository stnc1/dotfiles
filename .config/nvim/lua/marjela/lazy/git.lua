return {
    {
        "NeogitOrg/neogit",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "sindrets/diffview.nvim",
            "nvim-telescope/telescope.nvim"
        },
        config = function()
            require("neogit").setup({
                graph_style = "unicode",
                kind = "replace"
            })

            vim.keymap.set("n", "<leader>gg", function()
                vim.cmd("Neogit")
            end)
        end
    },
    {
        "lewis6991/gitsigns.nvim",
        config = function()
            require("gitsigns").setup({
                -- keymaps
                on_attach = function(bufnr)
                    local gitsigns = require('gitsigns')

                    local function map(mode, l, r, opts)
                        opts = opts or {}
                        opts.buffer = bufnr
                        vim.keymap.set(mode, l, r, opts)
                    end

                    -- show changes
                    map('n', '<leader>hp', gitsigns.preview_hunk)
                    -- list hunks in cur buff
                    map('n', '<leader>hl', gitsigns.setqflist)

                    -- reseting
                    map('n', '<leader>hr', gitsigns.reset_hunk)
                    map('v', '<leader>hr', function()
                        gitsigns.reset_hunk({ vim.fn.line('.'), vim.fn.line('v') })
                    end)

                    -- Text object
                    map({'o', 'x'}, 'ih', gitsigns.select_hunk)
                end
            })
        end
    },
    {
        "tpope/vim-fugitive",
        config = function()
            vim.keymap.set("n", "<leader>gb", function()
                vim.cmd("G blame")
            end)
        end
    }
}
