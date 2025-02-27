return {
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
                ensure_installed = { "lua_ls", "bashls", "clangd", "sqlls", "lemminx" }
            })
        end
    },
    { -- нужно для корректного отображения api nvim'а lsp
        "folke/neodev.nvim",
        opts = {},
        config = function()
            require("neodev").setup()
        end
    },
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

            lspconfig.bashls.setup({ --bash
                capabilities = capabilities
            })

            lspconfig.clangd.setup({ --c/c++
                capabilities = capabilities,
            })

            lspconfig.sqlls.setup({ --sql
                capabilities = capabilities
            })

            lspconfig.lemminx.setup({ --xml
                capabilities = capabilities
            })

            -- настройка окна документации
            vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "rounded" })
        end
    }
}
