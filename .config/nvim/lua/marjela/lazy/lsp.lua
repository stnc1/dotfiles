return {
    {
        "neovim/nvim-lspconfig",
        dependencies = {
            "hrsh7th/nvim-cmp",
            "hrsh7th/cmp-nvim-lsp",
        },

        config = function()
            local lspconfig = require("lspconfig")
            local capabilities = require("cmp_nvim_lsp").default_capabilities()

            lspconfig.lua_ls.setup({ --lua
                capabilities = capabilities,
                settings = {
                    Lua = {
                        runtime = {
                            version = "LuaJIT"
                        },
                        diagnostics = {
                            globals = { "vim", "it", "describe", "before_each", "after_each" }
                        },
                        workspace = {
                            library = vim.api.nvim_get_runtime_file("", true)
                        }
                    }
                }
            })

            -- maybe cycle
            lspconfig.clangd.setup({
                capabilities = capabilities,
            })
            lspconfig.gopls.setup({
                capabilities = capabilities,
            })
            lspconfig.sqlls.setup({
                capabilities = capabilities
            })
            lspconfig.yamlls.setup({
                capabilities = capabilities
            })
            lspconfig.lemminx.setup({
                capabilities = capabilities
            })
            lspconfig.taplo.setup({
                capabilities = capabilities
            })
            lspconfig.dockerls.setup({
                capabilities = capabilities
            })
            lspconfig.docker_compose_language_service.setup({
                capabilities = capabilities
            })

            -- Error detected while processing LspAttach Autocommands for "*":
            -- Error executing lua callback: /usr/share/nvim/runtime/lua/vim/lsp/_dynamic.lua:64: attempt to index local 'opts' (a number value)
            -- stack traceback:
            --     /usr/share/nvim/runtime/lua/vim/lsp/_dynamic.lua:64: in function 'get'
            --     /usr/share/nvim/runtime/lua/vim/lsp/_dynamic.lua:83: in function 'supports_method'
            --     /home/marjela/.config/nvim/lua/marjela/lazy/lsp.lua:62: in function </home/marjela/.config/nvim/lua/marjela/lazy/lsp.lua:57>
            --     [C]: in function 'nvim_exec_autocmds'
            --     /usr/share/nvim/runtime/lua/vim/lsp/client.lua:948: in function '_on_attach'
            --     /usr/share/nvim/runtime/lua/vim/lsp/client.lua:616: in function ''
            --     vim/_editor.lua: in function <vim/_editor.lua:0>

            vim.api.nvim_create_autocmd("LspAttach", {
                callback = function(args)
                    local client = vim.lsp.get_client_by_id(args.data.client_id)
                    if not client then return end

                    if client.supports_method("textDocument/formatting", { bufnr = 0 }) then
                        -- format buf on save
                        vim.api.nvim_create_autocmd("BufWritePre", {
                            buffer = args.buf,
                            callback = function()
                                vim.lsp.buf.format({ bufnr = args.buf, id = client.id })
                            end
                        })
                    end

                    local opts = { buffer = args.buf }
                    vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
                    vim.keymap.set("n", "gD", function() vim.lsp.buf.declaration() end, opts)
                    vim.keymap.set("n", "gI", function() vim.lsp.buf.implementation() end, opts)
                    vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts)

                    vim.keymap.set("n", "<leader>rn", function() vim.lsp.buf.rename() end, opts)
                    vim.keymap.set("n", "<leader>rr", function() vim.lsp.buf.references() end, opts)
                    vim.keymap.set("n", "<leader>ca", function() vim.lsp.buf.code_action() end, opts)
                    vim.keymap.set("i", "<C-d>", function() vim.lsp.buf.signature_help() end, opts)

                    vim.keymap.set("n", "<leader>od", function() vim.diagnostic.open_float() end, opts)
                    vim.keymap.set("n", "[d", function() vim.diagnostic.goto_next() end, opts)
                    vim.keymap.set("n", "]d", function() vim.diagnostic.goto_prev() end, opts)

                    -- disable lsp highlighting
                    vim.lsp.get_client_by_id(args.data.client_id).server_capabilities.semanticTokensProvider = nil
                end
            })

            -- настройка окна документации
            vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "rounded" })
        end
    },
    {
        "williamboman/mason.nvim",

        config = function()
            require('mason').setup()
        end
    },
    {
        "williamboman/mason-lspconfig.nvim",

        config = function()
            ---@diagnostic disable-next-line: missing-fields
            require("mason-lspconfig").setup({
                ensure_installed = {
                    "clangd",                         --  c/c++
                    "gopls",                          --  go
                    "lua_ls",                         --  lua

                    "sqlls",                          --  sql
                    "bashls",                         --  bash

                    "yamlls",                         --  yaml
                    "lemminx",                        --  xml
                    "taplo",                          --  toml

                    "dockerls",                       --  dockerfile
                    "docker_compose_language_service" --  dockercompose
                }
            })
        end
    },
    { -- нужно для корректного отображения api nvim'а lsp
        "folke/neodev.nvim",
        opts = {},
        config = function()
            require("neodev").setup()
        end
    }
}
