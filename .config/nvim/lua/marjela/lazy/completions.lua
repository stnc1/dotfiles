return {
    {
        "L3MON4D3/LuaSnip",
        dependencies = {
            "mireq/luasnip-snippets"
        },
        build = "make install_jsregexp"
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
                        { name = "path " }
                    }
                ),
                snippet = {
                    expand = function(args)
                        require("luasnip").lsp_expand(args.body)
                    end,
                },
            })

            -- TODO move to another file
            -- TODO markdown snippets

            local ls = require("luasnip")
            local s = ls.snippet
            local sn = ls.snippet_node
            local t = ls.text_node
            local i = ls.insert_node
            local c = ls.choice_node
            local d = ls.dynamic_node
            local su = require("luasnip_snippets.common.snip_utils")
            local cp = su.copy
            local tr = su.transform
            local jt = su.join_text
            local nl = su.new_line
            local te = su.trig_engine

            ls.add_snippets("go", {
                -- if
                s({ trig = "if", descr = "(if) \"if\"", priority = -50, trigEngine = te("b") }, {
                    t "if ", i(1, "", { key = "i1" }), t " {", nl(),
                    t "\t", i(2, "", { key = "i2" }), nl(),
                    t "}"
                }),
                -- else
                s({ trig = "el", descr = "(el) \"else\"", priority = -1000, trigEngine = te("w") }, {
                    t "else {", nl(),
                    t "\t", d(1,
                    function(args, snip)
                        return sn(nil,
                            { i(1, jt({ snip.env.LS_SELECT_DEDENT or {} }, "\t"), { key = "i0" }) })
                    end),
                    nl(),
                    t "}"
                }),
                -- if else
                s({ trig = "ife", descr = "(ife) \"if else condition\"", priority = -1000, trigEngine = te("w") }, {
                    t "if ", i(1, "", { key = "i1" }), t " {", nl(),
                    t "\t", d(2,
                    function(args, snip)
                        return sn(nil,
                            { i(1, jt({ snip.env.LS_SELECT_DEDENT or {} }, "\t"), { key = "i2" }) })
                    end),
                    nl(),
                    t "} else {", nl(),
                    t "\t", i(0, "", { key = "i0" }), nl(),
                    t "}"
                }),
                -- if err != nil
                s(
                    {
                        trig = "ir",
                        descr = "(ir) \"if error not nil\"",
                        priority = -1000,
                        trigEngine = te("w")
                    },
                    {
                        t "if err != nil {", nl(),
                        t "\t", i(1, "", { key = "i1" }), nl(),
                        t "}", nl(),
                        i(0, "", { key = "i0" })
                    }),

                -- v := vv
                s({ trig = ":", descr = "(:) \"Variable declaration :=\"", priority = -50, trigEngine = te("b") }, {
                    i(1, "name", { key = "i1" }), t " := ", i(0, "value", { key = "i0" })
                }),
                s({ trig = "v", descr = "(var) \"Variable declaration\"", priority = -50, trigEngine = te("b") }, {
                    t "var ", i(1, "name", { key = "i1" }), tr(2, "(.+)", " "), i(2, "type", { key = "i2" }), c(3,
                    { { t " = ", i(1, "value", { key = "i0" }) }, { i(1, jt({ " = ", "value" })) } }, { key = "i3" })
                }),
                s({ trig = "vr", descr = "(vr) \"variable initialization\"", priority = -1000, trigEngine = te("w") }, {
                    t "var ", i(1, "t", { key = "i1" }), t " ", i(0, "string", { key = "i0" })
                }),

                -- interface declaration
                s({ trig = "in", descr = "(in) \"full interface \"", priority = -1000, trigEngine = te("w") }, {
                    t "type ", i(1, "name", { key = "i1" }), t " interface {", nl(),
                    t "\t", i(2, "/* methods */", { key = "i2" }), nl(),
                    t "}"
                }),
                -- struct declaration
                s({ trig = "st", descr = "(st) \"struct\"", priority = -1000, trigEngine = te("w") }, {
                    t "type ", i(1, "name", { key = "i1" }), t " struct {", nl(),
                    t "\t", i(2, "/* data */", { key = "i2" }), nl(),
                    t "}", nl(),
                    i(0, "", { key = "i0" })
                }),

                -- switch case
                s({ trig = "sw", descr = "(sw) \"switch\"", priority = -1000, trigEngine = te("w") }, {
                    t "switch ", i(1, "var", { key = "i1" }), t " {", nl(),
                    t "case ", i(2, "value1", { key = "i2" }), t ":", nl(),
                    t "\t", i(3, "", { key = "i3" }), nl(),
                    t "default:", nl(),
                    t "\t", i(0, "", { key = "i0" }), nl(),
                    t "}"
                }),
                -- case
                s({ trig = "cs", descr = "(cs) \"case\"", priority = -1000, trigEngine = te("w") }, {
                    t "case ", i(1, "value", { key = "i1" }), t ":", nl(),
                    t "\t", d(2,
                    function(args, snip)
                        return sn(nil,
                            { i(1, jt({ snip.env.LS_SELECT_DEDENT or {} }, "\t"), { key = "i0" }) })
                    end)
                }),
                -- fallthrough
                s({ trig = "ft", descr = "(ft) \"fallthrough\"", priority = -1000, trigEngine = te("w") }, {
                    t "fallthrough"
                }),

                -- for
                s({ trig = "for", descr = "(for) \"for loop\"", priority = -1000, trigEngine = te("w") }, {
                    t "for ", i(1, "", { key = "i1" }), t "{", nl(),
                    t "\t", d(2,
                    function(args, snip)
                        return sn(nil,
                            { i(1, jt({ snip.env.LS_SELECT_DEDENT or {} }, "\t"), { key = "i0" }) })
                    end),
                    nl(),
                    t "}"
                }),
                s({ trig = "fori", descr = "(fori) \"for int loop\"", priority = -1000, trigEngine = te("w") }, {
                    t "for ", i(2, "i", { key = "i2" }), t " := 0; ", cp(2), t " < ", i(1, "count", { key = "i1" }), t "; ",
                    cp(2), i(
                    3, "++", { key = "i3" }), t " {", nl(),
                    t "\t", d(4,
                    function(args, snip)
                        return sn(nil,
                            { i(1, jt({ snip.env.LS_SELECT_DEDENT or {} }, "\t"), { key = "i0" }) })
                    end),
                    nl(),
                    t "}"
                }),
                s({ trig = "forr", descr = "(forr) \"for range loop\"", priority = -1000, trigEngine = te("w") }, {
                    t "for ", i(1, "e", { key = "i1" }), t " := range ", i(2, "collection", { key = "i2" }), t " {", nl(),
                    t "\t", d(3,
                    function(args, snip)
                        return sn(nil,
                            { i(1, jt({ snip.env.LS_SELECT_DEDENT or {} }, "\t"), { key = "i0" }) })
                    end),
                    nl(),
                    t "}"
                }),

                -- package
                s({ trig = "pa", descr = "(pa) \"package\"", priority = -1000, trigEngine = te("w") }, {
                    t "package ", i(1, "main", { key = "i1" })
                }),
                -- main func
                s({ trig = "main", descr = "(main) \"func main()\"", priority = -1000, trigEngine = te("w") }, {
                    t "func main() {", nl(),
                    t "\t", i(1, "", { key = "i1" }), nl(),
                    t "}", nl(),
                    i(0, "", { key = "i0" })
                }),

                -- maybe for copy?
                s({ trig = "ap", descr = "(ap) \"append\"", priority = -1000, trigEngine = te("w") }, {
                    t "append(", i(1, "slice", { key = "i1" }), t ", ", i(0, "value", { key = "i0" }), t ")"
                }),
                s({ trig = "ch", descr = "(ch) \"channel\"", priority = -1000, trigEngine = te("w") }, {
                    t "chan ", i(0, "int", { key = "i0" })
                }),
                s({ trig = "df", descr = "(df) \"defer\"", priority = -1000, trigEngine = te("w") }, {
                    t "defer ", i(0, "func", { key = "i0" }), t "()"
                }),
                s({ trig = "dfa", descr = "(df) \"defer\"", priority = -1000, trigEngine = te("w") }, {
                    t "defer func() {", nl(),
                    t "\t", i(1, "", { key = "i1" }), nl(),
                    t "}()"
                }),

                s({ trig = "im", descr = "(im) \"import\"", priority = -1000, trigEngine = te("w") }, {
                    t "import (", nl(),
                    t "\t\"", i(1, "package", { key = "i1" }), t "\"", nl(),
                    t ")"
                }),

                -- floats
                s({ trig = "f3", descr = "(f3) \"float32\"", priority = -1000, trigEngine = te("w") }, {
                    t "float32"
                }),
                s({ trig = "f6", descr = "(f6) \"float64\"", priority = -1000, trigEngine = te("w") }, {
                    t "float64"
                }),
                -- map
                s({ trig = "mp", descr = "(mp) \"map\"", priority = -1000, trigEngine = te("w") }, {
                    t "map[", i(1, "string", { key = "i1" }), t "]", i(0, "int", { key = "i0" })
                }),

                -- function
                s({ trig = "fn", descr = "(fun) \"function\"", priority = -1000, trigEngine = te("w") }, {
                    t "func ", i(1, "funcName", { key = "i1" }), t "(", i(2, "", { key = "i2" }), t ") ", i(3, "error",
                    { key = "i3" }),
                    t " {", nl(),
                    t "\t", i(4, "", { key = "i4" }), nl(),
                    t "}", nl(),
                    i(0, "", { key = "i0" })
                }),
                -- method
                s({ trig = "fm", descr = "(fum) \"method\"", priority = -1000, trigEngine = te("w") }, {
                    t "func (", i(1, "receiver", { key = "i1" }), t " ", i(2, "type", { key = "i2" }), t ") ", i(3,
                    "funcName",
                    { key = "i3" }), t "(", i(4, "", { key = "i4" }), t ") ", i(5, "error", { key = "i5" }), t " {", nl(),
                    t "\t", i(6, "", { key = "i6" }), nl(),
                    t "}", nl(),
                    i(0, "", { key = "i0" })
                }),

                -- make slice
                s({ trig = "mk", descr = "(mk) \"make\"", priority = -1000, trigEngine = te("w") }, {
                    t "make(", i(1, "[]string", { key = "i1" }), t ", ", i(0, "0", { key = "i0" }), t ")"
                }),

                -- prints
                s({ trig = "pf", descr = "(pf) \"fmt.Printf()\"", priority = -1000, trigEngine = te("w") }, {
                    t "fmt.Printf(\"%", i(1, "s", { key = "i1" }), t "\\n\", ", i(2, "var", { key = "i2" }), t ")"
                }),
                s({ trig = "pl", descr = "(pl) \"fmt.Println()\"", priority = -1000, trigEngine = te("w") }, {
                    t "fmt.Println(\"", i(1, "s", { key = "i1" }), t "\")"
                }),


                s({ trig = "pn", descr = "(pn) \"panic\"", priority = -1000, trigEngine = te("w") }, {
                    t "panic(\"", i(0, "msg", { key = "i0" }), t "\")"
                }),
                s({ trig = "rn", descr = "(rn) \"range\"", priority = -1000, trigEngine = te("w") }, {
                    t "range ", i(0, "", { key = "i0" })
                }),
                s({ trig = "rt", descr = "(rt) \"return\"", priority = -1000, trigEngine = te("w") }, {
                    t "return ", i(0, "", { key = "i0" })
                }),

                s({ trig = "sel", descr = "(sl) \"select\"", priority = -1000, trigEngine = te("w") }, {
                    t "select {", nl(),
                    t "case ", i(1, "v1", { key = "i1" }), t " := <-", i(2, "chan1", { key = "i2" }), nl(),
                    t "\t", i(3, "", { key = "i3" }), nl(),
                    t "default:", nl(),
                    t "\t", i(0, "", { key = "i0" }), nl(),
                    t "}"
                }),

                -- go named func
                s({ trig = "g", descr = "(g) \"goroutine named function\"", priority = -1000, trigEngine = te("w") }, {
                    t "go ", i(1, "funcName", { key = "i1" }), t "(", i(0, "", { key = "i0" }), t ")"
                }),
                -- go anon func
                s(
                    {
                        trig = "ga",
                        descr = "(ga) \"goroutine anonymous function\"",
                        priority = -1000,
                        trigEngine = te(
                            "w")
                    },
                    {
                        t "go func(", i(1, "", { key = "i1" }), t " ", i(2, "type", { key = "i2" }), t ") {", nl(),
                        t "\t", i(3, "/* code */", { key = "i3" }), nl(),
                        t "}(", i(0, "", { key = "i0" }), t ")"
                    }),

                -- test func
                s({ trig = "test", descr = "(test) \"test function\"", priority = -1000, trigEngine = te("w") }, {
                    t "func Test", i(1, "name", { key = "i1" }), t "(t *testing.T) {", nl(),
                    t "\t", d(2,
                    function(args, snip)
                        return sn(nil,
                            { i(1, jt({ snip.env.LS_SELECT_DEDENT or {} }, "\t"), { key = "i0" }) })
                    end),
                    nl(),
                    t "}"
                }),
                -- benchmark func
                s({ trig = "bench", descr = "(bench) \"benchmark function\"", priority = -1000, trigEngine = te("w") }, {
                    t "func Benchmark", i(1, "name", { key = "i1" }), t "(b *testing.B) {", nl(),
                    t "\tfor i := 0; i < b.N; i++ {", nl(),
                    t "\t\t", i(2, "", { key = "i2" }), nl(),
                    t "\t}", nl(),
                    t "}", nl(),
                    i(0, "", { key = "i0" })
                }),

                -- unused snippets, but maybe they'll be useful
                -- s({ trig = "vars", descr = "(vars) \"Variables declaration\"", priority = -50, trigEngine = te("b") }, {
                --     t "var (", nl(),
                --     t "\t", i(1, "name", { key = "i1" }), tr(2, "(.+)", " "), i(2, "type", { key = "i2" }), c(3,
                --     { { t " = ", i(1, "value", { key = "i0" }), t " " }, { i(1, jt({ " = ", "value", " " })) } }, { key = "i3" }), nl(),
                --     t ")"
                -- }),
                -- s({ trig = "co", descr = "(co) \"constants with iota\"", priority = -1000, trigEngine = te("w") }, {
                --     t "const (", nl(),
                --     t "\t", i(1, "NAME1", { key = "i1" }), t " = iota", nl(),
                --     t "\t", i(0, "NAME2", { key = "i0" }), nl(),
                --     t ")"
                -- }),
                -- s({ trig = "dfr", descr = "(dfr) \"defer recover\"", priority = -1000, trigEngine = te("w") }, {
                --     t "defer func() {", nl(),
                --     t "\tif err := recover(); err != nil {", nl(),
                --     t "\t\t", d(1,
                --     function(args, snip) return sn(nil, { i(1, jt({ snip.env.LS_SELECT_DEDENT or {} }, "\t\t"), { key = "i0" }) }) end),
                --     nl(),
                --     t "\t}", nl(),
                --     t "}()"
                -- }),
                -- s({ trig = "fumh", descr = "(fumh) \"http handler function on receiver\"", priority = -1000, trigEngine = te("w") },
                --     {
                --         t "func (", i(1, "receiver", { key = "i1" }), t " ", i(2, "type", { key = "i2" }), t ") ", i(3, "funcName",
                --         { key = "i3" }), t "(", i(4, "w", { key = "i4" }), t " http.ResponseWriter, ", i(5, "r", { key = "i5" }), t " *http.Request) {",
                --         nl(),
                --         t "\t", d(6,
                --         function(args, snip) return sn(nil, { i(1, jt({ snip.env.LS_SELECT_DEDENT or {} }, "\t"), { key = "i0" }) }) end),
                --         nl(),
                --         t "}"
                --     }),
                -- s({ trig = "lf", descr = "(lf) \"log printf\"", priority = -1000, trigEngine = te("w") }, {
                --     t "log.Printf(\"%", i(1, "s", { key = "i1" }), t "\", ", i(2, "var", { key = "i2" }), t ")"
                -- }),
                -- s({ trig = "lp", descr = "(lp) \"log println\"", priority = -1000, trigEngine = te("w") }, {
                --     t "log.Println(\"", i(1, "", { key = "i1" }), t "\")"
                -- }),
                -- s({ trig = "nw", descr = "(nw) \"new\"", priority = -1000, trigEngine = te("w") }, {
                --     t "new(", i(0, "type", { key = "i0" }), t ")"
                -- }),
                -- s({ trig = "testt", descr = "(testt) \"table test function\"", priority = -1000, trigEngine = te("w") }, {
                --     t "func Test", i(1, "name", { key = "i1" }), t "(t *testing.T) {", nl(),
                --     t "\ttests := []struct {", nl(),
                --     t "\t\tname string", nl(),
                --     t "\t}{", nl(),
                --     t "\t\t{", nl(),
                --     t "\t\t\tname: \"", i(2, "test name", { key = "i2" }), t "\",", nl(),
                --     t "\t\t},", nl(),
                --     t "\t}", nl(),
                --     nl(),
                --     t "\tfor _, test := range tests {", nl(),
                --     t "\t\tt.Run(test.name, func(t *testing.T) {", nl(),
                --     t "\t\t\t", d(3,
                --     function(args, snip) return sn(nil, { i(1, jt({ snip.env.LS_SELECT_DEDENT or {} }, "\t\t\t"), { key = "i0" }) }) end),
                --     nl(),
                --     t "\t\t})", nl(),
                --     t "\t}", nl(),
                --     t "}"
                -- }),
                -- s({ trig = "cl", descr = "(cl) \"composite literals\"", priority = -1000, trigEngine = te("w") }, {
                --     t "type ", i(1, "name", { key = "i1" }), t " struct {", nl(),
                --     t "\t", i(2, "attrName", { key = "i2" }), t " ", i(3, "attrType", { key = "i3" }), nl(),
                --     t "}"
                -- }),
                -- s({ trig = "om", descr = "(om) \"if key in a map\"", priority = -1000, trigEngine = te("w") }, {
                --     t "if ", i(1, "value", { key = "i1" }), t ", ok := ", i(2, "map", { key = "i2" }), t "[", i(3, "key",
                --     { key = "i3" }), t "]; ok == true {", nl(),
                --     t "\t", i(4, "/* code */", { key = "i4" }), nl(),
                --     t "}"
                -- }),
                -- s({ trig = "gg", descr = "(gg) \"Grouped globals with anonymous struct\"", priority = -1000, trigEngine = te("w") },
                --     {
                --         t "var ", i(1, "var", { key = "i1" }), t " = struct{", nl(),
                --         t "\t", i(2, "name", { key = "i2" }), t " ", i(3, "type", { key = "i3" }), nl(),
                --         t "}{", nl(),
                --         t "\t", cp(2), t ": ", i(4, "value", { key = "i4" }), t ",", nl(),
                --         t "}"
                --     }),
                -- s({ trig = "ja", descr = "(ja) \"Marshalable json alias\"", priority = -1000, trigEngine = te("w") }, {
                --     t "type ", i(1, "parentType", { key = "i1" }), t "Alias ", cp(1), nl(),
                --     nl(),
                --     t "func (p *", cp(1), t ") MarshalJSON() ([]byte, error) {", nl(),
                --     t "\treturn json.Marshal(&struct{ *", cp(1), t "Alias }{(*", cp(1), t "Alias)(p)})", nl(),
                --     t "}"
                -- }),
                -- s({ trig = "errwr", descr = "(errwr) \"Error handling with fmt.Errorf\"", priority = -1000, trigEngine = te("w") }, {
                --     t "if ", i(1, "", { key = "i1" }), t "err != nil {", nl(),
                --     t "\treturn fmt.Errorf(\"", i(2, "", { key = "i2" }), t " %w\", err)", nl(),
                --     t "}"
                -- }),
            })
        end
    }
}
