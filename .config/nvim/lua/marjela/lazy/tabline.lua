return {
    "akinsho/nvim-bufferline.lua",

    config = function()
        require("bufferline").setup({
            options = {
                numbers = "none",
                indicator = {
                    icon = "▎",
                    style = "icon"
                },
                groups = {
                    items = {
                        require('bufferline.groups').builtin.pinned:with({ icon = "" })
                    }
                },
                custom_filter = function(buf_number, buf_numbers)
                    local buftype = vim.bo[buf_number].buftype
                    if buftype == "nofile" or buftype == "quickfix" then
                        return false
                    end
                    return true
                end
            },

            highlights = {
                fill = {
                    bg = "#1a1a1c"
                }
            }
        })

        local opts = { noremap = true, silent = true }

        vim.keymap.set({ "n", "t" }, "<C-l>", function()
            vim.cmd("BufferLineCycleNext")
        end, opts)
        vim.keymap.set({ "n", "t" }, "<C-h>", function()
            vim.cmd("BufferLineCyclePrev")
        end, opts)

        vim.keymap.set("n", "<leader>n", function()
            vim.cmd("BufferLineMoveNext")
        end, opts)
        vim.keymap.set("n", "<leader>b", function()
            vim.cmd("BufferLineMovePrev")
        end, opts)

        vim.keymap.set({ "n", "t" }, "<C-r>", function()
            vim.cmd("BufferLinePick")
        end, opts)
    end
}
