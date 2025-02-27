return {
    {
        "nvim-telescope/telescope.nvim",

        tag = "0.1.5",

        dependencies = {
            "nvim-lua/plenary.nvim", -- required
            { "nvim-telescope/telescope-fzf-native.nvim", build = "make" }, -- for better perfomance
            "nvim-telescope/telescope-ui-select.nvim" -- for using telescope buffer rather than quick-fix buffer
        },

        config = function()
            local telescope = require('telescope')

            telescope.setup {
                pickers = {
                    find_files = {
                        hidden = true
                    }
                },
                extensions = {
                    fzf = {},
                    ["ui-select"] = {
                        require("telescope.themes").get_dropdown {}
                    }
                }
            }

            telescope.load_extension("fzf")
            telescope.load_extension("ui-select")

            local builtin = require('telescope.builtin')

            -- find files in root
            vim.keymap.set('n', '<leader>fr', function()
                builtin.find_files({ cwd = '/'})
            end, {})
            -- find files in $HOME 
            vim.keymap.set('n', '<leader>fh', function()
                builtin.find_files({ cwd = os.getenv('HOME')})
            end, {})
            -- find files in dir where nvim was opened 
            vim.keymap.set('n', '<leader>fb', builtin.find_files, {})
            -- find files in current buffer_dir
            vim.keymap.set('n', '<leader>ff', function()
                local dir = require("telescope.utils").buffer_dir()
                if string.find(dir, "oil://") then
                    dir = dir:sub(7, dir:len())
                end
                builtin.find_files({ cwd = dir })
            end, {})

            -- find files in git repo (faster) 
            vim.keymap.set('n', '<leader>gf', function ()
                builtin.git_files({ cwd = require("telescope.utils").buffer_dir() })
            end, {})
            -- find word in files
            vim.keymap.set('n', '<leader>fw', builtin.live_grep, {})
            -- find word under cursor
            vim.keymap.set('n', '<leader>*', builtin.grep_string, {})

            vim.keymap.set('n', '<leader>vh', builtin.help_tags, {})
        end
    }
}
