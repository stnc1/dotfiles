return {
    {
        "neovim/nvim-lspconfig",

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

            local servers = {
                clangd = {},
                gopls = {},
                sqlls = {},
                bashls = {},
                yamlls = {},
                lemminx = {},
                taplo = {},
                dockerls = {},
                docker_compose_language_service = {}
            }

            for name, _ in pairs(servers) do
                lspconfig[name].setup({
                    capabilities = capabilities
                })
            end

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

                    vim.keymap.set("n", "<leader>do", function() vim.diagnostic.open_float() end, opts)
                    vim.keymap.set("n", "<leader>dl", function() vim.diagnostic.setqflist() end, opts)
                    vim.keymap.set("n", "]d", function() vim.diagnostic.goto_next() end, opts)
                    vim.keymap.set("n", "[d", function() vim.diagnostic.goto_prev() end, opts)

                    -- disable lsp highlighting
                    vim.lsp.get_client_by_id(args.data.client_id).server_capabilities.semanticTokensProvider = nil
                end
            })
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
