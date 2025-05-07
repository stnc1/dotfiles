return {
    {
        "L3MON4D3/LuaSnip",
        dependencies = {
            "mireq/luasnip-snippets"
        },
        build = "make install_jsregexp",
        config = function()
            dofile("/home/marjela/.config/nvim/lua/marjela/snippets.lua")
        end
    },
    {
        "hrsh7th/nvim-cmp",
        dependencies = {
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-path",
            "hrsh7th/cmp-buffer",
            "L3MON4D3/LuaSnip",
            "saadparwaiz1/cmp_luasnip",
        },

        config = function()
            local cmp = require("cmp")
            local luasnip = require("luasnip")

            cmp.setup({
                mapping = cmp.mapping.preset.insert({
                    ["<C-e>"] = cmp.mapping.abort(),
                    ['<CR>'] = cmp.mapping(
                        function(fallback)
                            if cmp.visible() then
                                if luasnip.expandable() then
                                    luasnip.expand()
                                else
                                    cmp.confirm({
                                        select = true,
                                    })
                                end
                            else
                                fallback()
                            end
                        end
                    ),
                    ["<Tab>"] = cmp.mapping(
                        function(fallback)
                            if cmp.visible() then
                                cmp.select_next_item()
                            elseif luasnip.locally_jumpable(1) then
                                luasnip.jump(1)
                            else
                                fallback()
                            end
                        end, { "i", "s" }
                    ),

                    ["<S-Tab>"] = cmp.mapping(
                        function(fallback)
                            if cmp.visible() then
                                cmp.select_prev_item()
                            elseif luasnip.locally_jumpable(-1) then
                                luasnip.jump(-1)
                            else
                                fallback()
                            end
                        end, { "i", "s" }
                    ),
                }),
                sources = cmp.config.sources(
                    {
                        { name = "nvim_lsp" },
                        { name = "luasnip" },
                        { name = "buffer" },
                        { name = "path" }
                    }
                ),
                snippet = {
                    expand = function(args)
                        require("luasnip").lsp_expand(args.body)
                    end,
                },
            })
        end
    }
}
