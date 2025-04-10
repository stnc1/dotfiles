return {
    {
        "nvim-telescope/telescope.nvim",

        dependencies = {
            "nvim-lua/plenary.nvim",                                        -- required
            { "nvim-telescope/telescope-fzf-native.nvim", build = "make" }, -- for better perfomance
        },

        config = function()
            local telescope = require("telescope")

            telescope.setup {
                defaults = {
                    vimgrep_arguments = {
                        'rg',
                        '--color=never',
                        '--no-heading',
                        '--with-filename',
                        '--line-number',
                        '--column',
                        '--smart-case',
                        '--hidden',
                        '-u'
                    }
                },
                pickers = {
                    find_files = {
                        hidden = true
                    }
                },
                extensions = {
                    fzf = {},
                }
            }

            telescope.load_extension("fzf")

            local builtin = require("telescope.builtin")

            -- find files in root
            vim.keymap.set("n", "<leader>fr", function()
                builtin.find_files({ cwd = "/" })
            end, {})
            -- find files in $HOME
            vim.keymap.set("n", "<leader>fh", function()
                builtin.find_files({ cwd = os.getenv("HOME") })
            end, {})

            vim.keymap.set("n", "<leader>ff", function()
                if pcall(function()
                        builtin.git_files({
                            cwd = require("telescope.utils").buffer_dir(),
                            show_untracked = true
                        })
                    end) == false then
                    builtin.find_files()
                end
            end, {})

            vim.keymap.set("n", "<leader>vh", builtin.help_tags, {})
        end
    }
}
