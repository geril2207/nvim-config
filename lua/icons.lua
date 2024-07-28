local M = {}

--- Diagnostic severities.
M.diagnostics = {
	ERROR = "",
	WARN = "",
	HINT = "",
	INFO = "",
}

--- For folding.
M.arrows = {
	right = "",
	left = "",
	up = "",
	down = "",
}

--- LSP symbol kinds.
M.symbol_kinds = {
	Text = "",
	Method = "",
	Function = "",
	Constructor = "",
	Field = "",
	Variable = "",
	Class = "",
	Interface = "",
	Module = "",
	Property = "",
	Unit = "",
	Value = "",
	Enum = "",
	Keyword = "",
	Snippet = "",
	Color = "",
	File = "",
	Reference = "",
	Folder = "",
	EnumMember = "",
	Constant = "",
	Struct = "",
	Event = "",
	Operator = "",
	TypeParameter = "",
}

--- Shared icons that don't really fit into a category.
M.misc = {
	bug = "",
	ellipsis = "…",
	git = "",
	search = "",
	vertical_bar = "│",
}

return M
