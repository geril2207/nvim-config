local utils = require("config.utils")
local transparent = utils.transparent

require("catppuccin").setup({
	flavour = "macchiato",
	-- flavour = "mocha",
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
				NvimTreeCursorLine = { fg = colors.peach, bg = transparent and colors.none or colors.surface0 },
				NvimTreeCursorLineNr = { fg = colors.text, bg = colors.none },
				TelescopeSelection = {
					fg = transparent and colors.peach or colors.peach,
					bg = transparent and colors.none or colors.surface0,
					style = { "bold" },
				},
				WinBarFilePath = { fg = colors.overlay0 },
				WinbarFile = { fg = colors.flamingo },
				WinBarNC = { bg = colors.none },
				WinbarSeparator = { fg = colors.text },
				InclineNormal = { bg = colors.none, fg = colors.flamingo },
				InclineNormalNC = { bg = colors.none, fg = colors.overlay0 },
				Cursor = { blend = 100 },

				["@keyword.export"] = { fg = colors.mauve },
			}
		end,
	},

	term_colors = false,
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
		fidget = false,
		telescope = true,
		lsp_saga = false,
	},
})

vim.cmd("colorscheme catppuccin")
