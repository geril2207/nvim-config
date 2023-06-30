local luasnip = require("luasnip")

local s = luasnip.snippet
local i = luasnip.insert_node
local f = luasnip.function_node
local fmt = require("luasnip.extras.fmt").fmt

luasnip.setup({
	region_check_events = "InsertEnter",
	delete_check_events = "TextChanged,InsertLeave",
	update_events = "TextChanged,TextChangedI",
})

require("luasnip.loaders.from_vscode").lazy_load()

local jsx_snippets = {
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

luasnip.add_snippets("typescriptreact", jsx_snippets)
luasnip.add_snippets("javascriptreact", jsx_snippets)
