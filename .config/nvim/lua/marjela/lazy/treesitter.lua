return {
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        config = function()
            require("nvim-treesitter.configs").setup({
                -- A list of parser names, or "all"
                ensure_installed = {
                    "vimdoc", "c", "lua", "bash", "java", "sql", "markdown", "markdown_inline", "go", "comment"
                },
                sync_install = false,
                auto_install = true,
                indent = {
                    enable = true
                },
                highlight = {
                    enable = true,
                    additional_vim_regex_highlighting = false
                },
                modules = {},
                ignore_install = {}
            })

            local parser_config = require("nvim-treesitter.parsers").get_parser_configs()
            parser_config.templ = {
                install_info = {
                    url = "https://github.com/vrischmann/tree-sitter-templ.git",
                    files = { "src/parser.c", "src/scanner.c" },
                    branch = "master",
                }
            }

            vim.treesitter.language.register("templ", "templ")
        end
    },
    {
        "nvim-treesitter/nvim-treesitter-context"
    }
}
