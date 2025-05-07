local ls = require("luasnip")
local s = ls.snippet
local sn = ls.snippet_node
local t = ls.text_node
local i = ls.insert_node
local d = ls.dynamic_node

local su = require("luasnip_snippets.common.snip_utils")
local cp = su.copy
local jt = su.join_text
local nl = su.new_line
local te = su.trig_engine

ls.add_snippets("go", {
    -- if
    s({ trig = "if", desc = "if" }, {
        t "if ", i(1, "", { key = "i1" }), t " {", nl(),
        t "\t", i(2, "", { key = "i2" }), nl(),
        t "}", i(0, "", { key = "i0" })
    }),
    -- else
    s({ trig = "el", desc = "else" }, {
        t "else {", nl(),
        t "\t", d(1,
        function(args, snip)
            return sn(nil,
                { i(1, jt({ snip.env.LS_SELECT_DEDENT or {} }, "\t"), { key = "i1" }) })
        end),
        nl(),
        t "}", i(0, "", { key = "i0" })
    }),
    -- if else
    s({ trig = "ife", desc = "if else" }, {
        t "if ", i(1, "", { key = "i1" }), t " {", nl(),
        t "\t", d(2,
        function(args, snip)
            return sn(nil,
                { i(1, jt({ snip.env.LS_SELECT_DEDENT or {} }, "\t"), { key = "i2" }) })
        end),
        nl(),
        t "} else {", nl(),
        t "\t", i(3, "", { key = "i3" }), nl(),
        t "}", i(0, "", { key = "i0" })
    }),
    -- if err != nil
    s(
        {
            trig = "ir",
            desc = "if error not nil",
            priority = -1000,
            trigEngine = te("w")
        },
        {
            t "if err != nil {", nl(),
            t "\t", i(1, "", { key = "i1" }), nl(),
            t "}", i(0, "", { key = "i0" })
        }),

    -- v := vv
    s({ trig = ":", desc = "var initialization" }, {
        i(1, "", { key = "i1" }), t " := ", i(2, "", { key = "i2" }), i(0, "", { key = "i0" })
    }),
    s({ trig = "v", desc = "var declaration" }, {
        t "var ", i(1, "", { key = "i1" }), i(2, "", { key = "i2" }), i(0, "", { key = "i0" })
    }),
    s({ trig = "vr", desc = "var full initialization" }, {
        t "var ", i(1, "", { key = "i1" }), t " = ", i(2, "", { key = "i2" }), i(0, "", { key = "i0" })
    }),

    -- interface declaration
    s({ trig = "in", desc = "full interface " }, {
        t "type ", i(1, "name", { key = "i1" }), t " interface {", nl(),
        t "\t", i(2, "/* methods */", { key = "i2" }), nl(),
        t "}", nl(), i(0, "", { key = "i0" })
    }),
    -- struct declaration
    s({ trig = "st", desc = "struct" }, {
        t "type ", i(1, "name", { key = "i1" }), t " struct {", nl(),
        t "\t", i(2, "/* data */", { key = "i2" }), nl(),
        t "}", nl(), i(0, "", { key = "i0" })
    }),

    -- switch case
    s({ trig = "sw", desc = "switch" }, {
        t "switch ", i(1, "var", { key = "i1" }), t " {", nl(),
        t "case ", i(2, "value1", { key = "i2" }), t ":", nl(),
        t "\t", i(3, "", { key = "i3" }), nl(),
        t "default:", nl(),
        t "\t", i(4, "", { key = "i4" }), nl(),
        t "}", i(0, "", { key = "i0" })
    }),
    -- case
    s({ trig = "ca", desc = "case" }, {
        t "case ", i(1, "value", { key = "i1" }), t ":", nl(),
        t "\t", d(2,
        function(args, snip)
            return sn(nil,
                { i(1, jt({ snip.env.LS_SELECT_DEDENT or {} }, "\t"), { key = "i2" }) })
        end), i(0, "", { key = "i0" })
    }),
    -- fallthrough
    s({ trig = "fa", desc = "fallthrough" }, {
        t "fallthrough"
    }),

    -- for
    s({ trig = "for", desc = "for loop" }, {
        t "for ", i(1, "", { key = "i1" }), t "{", nl(),
        t "\t", d(2,
        function(args, snip)
            return sn(nil,
                { i(1, jt({ snip.env.LS_SELECT_DEDENT or {} }, "\t"), { key = "i2" }) })
        end),
        nl(),
        t "}", i(0, "", { key = "i0" })
    }),
    s({ trig = "fori", desc = "for int loop" }, {
        t "for ", i(2, "i", { key = "i2" }), t " := 0; ", cp(2), t " < ", i(1, "count", { key = "i1" }), t "; ",
        cp(2), i(
        3, "++", { key = "i3" }), t " {", nl(),
        t "\t", d(4,
        function(args, snip)
            return sn(nil,
                { i(1, jt({ snip.env.LS_SELECT_DEDENT or {} }, "\t"), { key = "i4" }) })
        end),
        nl(),
        t "}", i(0, "", { key = "i0" })
    }),
    s({ trig = "forr", desc = "for range loop" }, {
        t "for ", i(1, "e", { key = "i1" }), t " := range ", i(2, "collection", { key = "i2" }), t " {", nl(),
        t "\t", d(3,
        function(args, snip)
            return sn(nil,
                { i(1, jt({ snip.env.LS_SELECT_DEDENT or {} }, "\t"), { key = "i3" }) })
        end),
        nl(),
        t "}", i(0, "", { key = "i0" })
    }),

    -- package
    s({ trig = "pa", desc = "package" }, {
        t "package ", i(1, "", { key = "i1" }), nl(), i(0, "", { key = "i0" })
    }),
    -- main func
    s({ trig = "main", desc = "main file setup" }, {
        t "package main", nl(), nl(),
        t "func main() {", nl(),
        t "\t", i(1, "", { key = "i1" }), nl(),
        t "}", i(0, "", { key = "i0" })
    }),

    -- maybe for copy?
    s({ trig = "ap", desc = "append" }, {
        t "append(", i(1, "", { key = "i1" }), t ", ", i(2, "", { key = "i2" }), t ")", i(0, "", { key = "i0" })
    }),
    s({ trig = "ch", desc = "channel" }, {
        t "chan ", i(1, "int", { key = "i1" }), i(0, "", { key = "i0" })
    }),
    s({ trig = "df", desc = "defer func" }, {
        t "defer ", i(1, "", { key = "i1" }), t "()", i(0, "", { key = "i0" })
    }),
    s({ trig = "dfa", desc = "defer anonymous func" }, {
        t "defer func() {", nl(),
        t "\t", i(1, "", { key = "i1" }), nl(),
        t "}()", i(0, "", { key = "i0" })
    }),

    s({ trig = "im", desc = "import" }, {
        t "import (", nl(),
        t "\t\"", i(1, "", { key = "i1" }), t "\"", nl(),
        t ")", nl(), i(0, "", { key = "i0" })
    }),

    -- floats
    s({ trig = "f3", desc = "float32" }, {
        t "float32"
    }),
    s({ trig = "f6", desc = "float64" }, {
        t "float64"
    }),
    -- map
    s({ trig = "map", desc = "map" }, {
        t "map[", i(1, "", { key = "i1" }), t "]", i(0, "", { key = "i0" })
    }),

    -- function
    s({ trig = "fun", desc = "function" }, {
        t "func ", i(1, "funcName", { key = "i1" }), t "(", i(2, "", { key = "i2" }), t ") ", i(3, "error",
        { key = "i3" }),
        t " {", nl(),
        t "\t", i(4, "", { key = "i4" }), nl(),
        t "}", nl(),
        i(0, "", { key = "i0" })
    }),
    -- method
    s({ trig = "fum", desc = "method" }, {
        t "func (", i(1, "receiver", { key = "i1" }), t " ", i(2, "type", { key = "i2" }), t ") ", i(3,
        "funcName",
        { key = "i3" }), t "(", i(4, "", { key = "i4" }), t ") ", i(5, "error", { key = "i5" }), t " {", nl(),
        t "\t", i(6, "", { key = "i6" }), nl(),
        t "}", nl(),
        i(0, "", { key = "i0" })
    }),

    s({ trig = "make", desc = "make" }, {
        t "make(", i(1, "", { key = "i1" }), t ", ", i(2, "2", { key = "i0" }), t ")", i(0, "", { key = "i0" })
    }),

    -- prints
    s({ trig = "pf", desc = "fmt.Printf()" }, {
        t "fmt.Printf(\"%", i(1, "s", { key = "i1" }), t "\\n\", ", i(2, "var", { key = "i2" }), t ")", i(0, "",
        { key = "i0" })
    }),
    s({ trig = "pl", desc = "fmt.Println()" }, {
        t "fmt.Println(\"", i(1, "s", { key = "i1" }), t "\")", i(0, "", { key = "i0" })
    }),


    s({ trig = "pa", desc = "panic" }, {
        t "panic(\"", i(0, "msg", { key = "i0" }), t "\")", i(0, "", { key = "i0" })
    }),
    s({ trig = "ra", desc = "range" }, {
        t "range ", i(0, "", { key = "i0" })
    }),
    s({ trig = "re", desc = "return" }, {
        t "return ", i(0, "", { key = "i0" })
    }),

    s({ trig = "sel", desc = "select" }, {
        t "select {", nl(),
        t "case ", i(1, "v1", { key = "i1" }), t " := <-", i(2, "chan1", { key = "i2" }), nl(),
        t "\t", i(3, "", { key = "i3" }), nl(),
        t "default:", nl(),
        t "\t", i(0, "", { key = "i0" }), nl(),
        t "}", i(0, "", { key = "i0" })
    }),

    -- go named func
    s({ trig = "g", desc = "goroutine named function" }, {
        t "go ", i(1, "funcName", { key = "i1" }), t "(", i(0, "", { key = "i0" }), t ")"
    }),
    -- go anon func
    s(
        { trig = "ga", desc = "goroutine anonymous function" },
        {
            t "go func(", i(1, "", { key = "i1" }), t " ", i(2, "type", { key = "i2" }), t ") {", nl(),
            t "\t", i(3, "/* code */", { key = "i3" }), nl(),
            t "}(", i(4, "", { key = "i4" }), t ")", i(0, "", { key = "i0" })
        }),

    -- test func
    s({ trig = "test", desc = "test function" }, {
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
    s({ trig = "bench", desc = "benchmark function" }, {
        t "func Benchmark", i(1, "name", { key = "i1" }), t "(b *testing.B) {", nl(),
        t "\tfor i := 0; i < b.N; i++ {", nl(),
        t "\t\t", i(2, "", { key = "i2" }), nl(),
        t "\t}", nl(),
        t "}"
    }),

})

ls.add_snippets("markdown", {
    s({ trig = "*", desc = "italics", priority = 800 }, {
        t "*", i(1, "", { key = "i1" }), t "*", i(0, "", { key = "i0" })
    }),
    s({ trig = "**", desc = "bold", priority = 900 }, {
        t "**", i(1, "", { key = "i1" }), t "**", i(0, "", { key = "i0" })
    }),
    s({ trig = "***", desc = "bold italics", priority = 1000 }, {
        t "***", i(1, "", { key = "i1" }), t "***", i(0, "", { key = "i0" })
    }),
    s({ trig = "-", desc = "bar" }, {
        t "---", nl()
    }),
    s({ trig = "link", desc = "link to something" }, {
        t "[", i(1, "", { key = "i1" }), t "](", i(2, "", { key = "i2" }), t ")", i(0, "", { key = "i0" })
    }),
    s({ trig = "url", desc = "link to url" }, {
        t "[", i(1, "", { key = "i1" }), t "](https://", i(2, "", { key = "i2" }), t ")", i(0, "", { key = "i0" })
    }),
    s({ trig = "img", desc = "image" }, {
        t "![", i(1, "", { key = "i1" }), t "](", i(2, "", { key = "i2" }), t ")", i(0, "", { key = "i0" })
    }),
    s({ trig = "code", desc = "codeblock" }, {
        t "```", i(1, "", { key = "i1" }), nl(),
        i(2, "", { key = "i2" }), nl(),
        t "```", i(0, "", { key = "i0" })
    }),
})
