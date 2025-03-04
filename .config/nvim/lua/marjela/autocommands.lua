-- autochdir for oil buffers
vim.api.nvim_create_autocmd("BufEnter", {
    pattern = "oil://*",
    callback = function()
        local cwd = require("oil").get_current_dir()
        if cwd then
            vim.cmd("cd " .. cwd)
        end
    end
})

-- auto insert on entering term
vim.api.nvim_create_autocmd({ "TermOpen", "BufEnter" }, {
    pattern = "term://*",
    callback = function()
        vim.cmd.startinsert()
    end
})
