-- moving selected items up and down
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- center cursor while navigating
vim.keymap.set("n", "<c-d>", "<c-d>zz")
vim.keymap.set("n", "<c-u>",  "<c-u>zz")

-- keeps searching results in the middle
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- pasting without loosing yanked content
vim.keymap.set("x", "<leader>p", "\"_dP")

-- yanking in system clipboard
vim.keymap.set("n", "<leader>y", "\"+y")
vim.keymap.set("v", "<leader>y", "\"+y")
vim.keymap.set("n", "<leader>Y", "\"+Y")

-- pasting from system clipboard
vim.keymap.set("n", "<leader>P", "\"+p")
vim.keymap.set("v", "<leader>P", "\"+p")

-- deleting in void reg
vim.keymap.set("v", "<leader>d", "\"_d")
vim.keymap.set("n", "<leader>d", "\"_d")

-- close buf
vim.keymap.set('n', '<Leader>q', ':bd<CR>')

-- format buf
vim.keymap.set('n', '<Leader>F', 'ggVG=')

vim.api.nvim_create_autocmd('LspAttach', {
    callback = function(e)
        local opts = { buffer = e.buf }
        vim.keymap.set("n", "gd", function() require('telescope.builtin').lsp_definitions() end, opts)
        vim.keymap.set("n", "gD", function() vim.lsp.buf.declaration() end, opts)
        vim.keymap.set("n", "gI", function() vim.lsp.buf.implementation() end, opts)
        vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts)

        vim.keymap.set("n", "<leader>rn", function() vim.lsp.buf.rename() end, opts)
        vim.keymap.set("n", "<leader>rr", function() require('telescope.builtin').lsp_references() end, opts)
        vim.keymap.set("n", "<leader>ca", function() vim.lsp.buf.code_action() end, opts)
        vim.keymap.set("i", "<C-d>", function() vim.lsp.buf.signature_help() end, opts)

        vim.keymap.set("n", "<leader>od", function() vim.diagnostic.open_float() end, opts)
        vim.keymap.set("n", "[d", function() vim.diagnostic.goto_next() end, opts)
        vim.keymap.set("n", "]d", function() vim.diagnostic.goto_prev() end, opts)

        vim.lsp.get_client_by_id(e.data.client_id).server_capabilities.semanticTokensProvider = nil
    end
})
