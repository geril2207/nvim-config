local luasnip = require("luasnip")

local s = luasnip.snippet
local i = luasnip.insert_node
local f = luasnip.function_node
local fmt = require("luasnip.extras.fmt").fmt
local extras = require("luasnip.extras")
local rep = extras.rep

luasnip.setup({
	region_check_events = "InsertEnter",
	delete_check_events = "TextChanged,InsertLeave",
	update_events = "TextChanged,TextChangedI",
})

require("luasnip.loaders.from_vscode").lazy_load()

local js_snippets = {
	s("clo", fmt("console.log('{} :', {})", { i(1, "value"), rep(1) })),
	s("clg", fmt("console.log({})", { i(1, "value") })),
	s(
		"useStateSnippet",
		fmt("const [{value}, {setValue}] = useState({initValue})", {
			value = i(1, "value"),
			setValue = f(function(value_table)
				local value = value_table[1][1]
				local first_upper = value:gsub("^%l", string.upper)
				return "set" .. first_upper
			end, { 1 }),
			initValue = i(2, "initialValue"),
		})
	),
}

luasnip.add_snippets("typescriptreact", js_snippets)
luasnip.add_snippets("javascriptreact", js_snippets)
luasnip.add_snippets("typescript", js_snippets)
luasnip.add_snippets("javascript", js_snippets)
--
-- luasnip.filetype_extend("typescript", { "typescriptreact" })
-- luasnip.filetype_extend("javascript", { "javascriptreact" })
