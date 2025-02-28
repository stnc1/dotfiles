return {
    { -- provides undotree with branches
        "mbbill/undotree",
        config = function() vim.keymap.set("n", "<leader>u", vim.cmd.UndotreeToggle)
        end
    },
    { -- automatically makes pairs for (,{,[,",',` etc.
        "echasnovski/mini.pairs",
        version = false,
        config = function()
            require("mini.pairs").setup()
        end
    },
    { -- provides several text-objects, and allows to create your own
        "echasnovski/mini.ai",
        version = false,
        config = function()
            require("mini.ai").setup()
        end
    }
}
