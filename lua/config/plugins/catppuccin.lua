local utils = require("utils")
local transparent = utils.transparent

require("catppuccin").setup({
	flavour = "mocha",
	transparent_background = transparent,
	highlight_overrides = {
		all = function(colors)
			return {
				DiagnosticSignWarn = { fg = colors.yellow, bg = colors.none },
				DiagnosticSignHint = { fg = colors.teal, bg = colors.none },
				DiagnosticSignInfo = { fg = colors.peach, bg = colors.none },
				DiagnosticSignError = { fg = colors.red, bg = colors.none },
				DiagnosticVirtualTextWarn = { fg = colors.yellow, bg = colors.none },
				DiagnosticVirtualTextHint = { fg = colors.teal, bg = colors.none },
				DiagnosticVirtualTextInfo = { fg = colors.peach, bg = colors.none },
				DiagnosticVirtualTextError = { fg = colors.red, bg = colors.none },
				-- CursorLineNr = { fg = colors.text, bg = colors.none },
				-- NvimTreeCursorLine = { fg = colors.flamingo, bg = colors.surface0 },
				NvimTreeCursorLineNr = { fg = colors.text, bg = colors.none },
				TelescopeSelection = {
					fg = transparent and colors.peach or colors.text,
					bg = transparent and colors.none or colors.surface0,
					style = { "bold" },
				},
				WinBar = { fg = colors.text },
			}
		end,
	},

	term_colors = true,
	no_italic = true, -- Force no italic
	no_bold = true, -- Force no bold
	styles = {
		comments = {},
		conditionals = {},
		loops = {},
		functions = {},
		keywords = {},
		strings = {},
		variables = {},
		numbers = {},
		booleans = {},
		properties = {},
		types = {},
		operators = {},
	},

	integrations = {
		hop = false,
		cmp = true,
		gitsigns = true,
		nvimtree = true,
		treesitter = true,
		fidget = true,
		telescope = true,
		lsp_saga = false,
	},
})

utils.setup_color_scheme("catppuccin")
