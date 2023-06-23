local transparent = vim.fn.has("gui_running") == 0

require("gruvbox").setup({
	undercurl = true,
	underline = true,
	bold = false,
	italic = {
		strings = false,
		comments = false,
		operators = false,
		folds = false,
	},
	hrough = true,
	invert_selection = false,
	invert_signs = false,
	invert_tabline = false,
	invert_intend_guides = false,
	inverse = true, -- invert background for search, diffs, statuslines and errors
	contrast = "", -- can be "hard", "soft" or empty string
	overrides = {
		DiagnosticSignWarn = { fg = "#d79921", bg = "none" },
		DiagnosticSignHint = { fg = "#8ec07c", bg = "none" },
		DiagnosticSignInfo = { fg = "#83a598", bg = "none" },
		DiagnosticSignError = { fg = "#fb4934", bg = "none" },
		GitSignsAdd = { fg = "#b8bb26", bg = "none" },
		GitSignsChange = { fg = "#8ec07c", bg = "none" },
		GitSignsDelete = { fg = "#fb4934", bg = "none" },
		-- Pmenu = {bg = "none"}
	},
	transparent_mode = transparent,
})

vim.g.catppuccin_flavour = "macchiato" -- latte, frappe, macchiato, mocha
require("catppuccin").setup({
	transparent_background = transparent,
	custom_highlights = function(colors)
		return {
			DiagnosticSignWarn = { fg = colors.yellow, bg = "none" },
			DiagnosticSignHint = { fg = colors.teal, bg = "none" },
			DiagnosticSignInfo = { fg = colors.peach, bg = "none" },
			DiagnosticSignError = { fg = colors.red, bg = "none" },
		}
	end,

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
})

require("onedarkpro").setup({
	options = {
		transparency = transparent,
	},
})

require("lualine").setup({
	options = {
		icons_enabled = true,
		theme = "auto",
		component_separators = { left = "", right = "" },
		section_separators = { left = "", right = "" },
		disabled_filetypes = {
			statusline = {},
			winbar = {},
		},
		ignore_focus = {},
		always_divide_middle = true,
		globalstatus = false,
		refresh = {
			statusline = 1000,
			tabline = 1000,
			winbar = 1000,
		},
	},
	sections = {
		lualine_a = { "mode" },
		lualine_b = { "branch", "diff", "diagnostics" },
		lualine_c = { "filename" },
		lualine_x = { "encoding", "fileformat", "filetype" },
		lualine_y = { "progress" },

		lualine_z = { "location" },
	},
	inactive_sections = {
		lualine_a = {},
		lualine_b = {},
		lualine_c = { "filename" },
		lualine_x = { "location" },
		lualine_y = {},
		lualine_z = {},
	},
	tabline = {},
	winbar = {},
	inactive_winbar = {},
	extensions = {},
})

require("tokyonight").setup({
	-- your configuration comes here
	-- or leave it empty to use the default settings
	style = "storm", -- The theme comes in three styles, `storm`, `moon`, a darker variant `night` and `day`
	transparent = transparent, -- Enable this to disable setting the background color
	terminal_colors = false, -- Configure the colors used when opening a `:terminal` in Neovim
	styles = {
		comments = { italic = false },
		keywords = { italic = false },
		functions = { italic = false },
		variables = { italic = false },
		sidebars = "transparent", -- style for sidebars, see below
		floats = "transparent", -- style for floating windows
	},
	sidebars = { "qf", "help" }, -- Set a darker background on sidebar-like windows. For example: `["qf", "vista_kind", "terminal", "packer"]`
	day_brightness = 0.2, -- Adjusts the brightness of the colors of the **Day** style. Number between 0 and 1, from dull to vibrant colors
	hide_inactive_statusline = false, -- Enabling this option, will hide inactive statuslines and replace them with a thin border instead. Should work with the standard **StatusLine** and **LuaLine**.
	dim_inactive = false, -- dims inactive windows
	lualine_bold = false, -- When `true`, section headers in the lualine theme will be bold
	on_highlights = function(hl, c)
		hl.DiagnosticVirtualTextHint = {
			bg = c.none,
			fg = c.hint,
		}
		hl.DiagnosticVirtualTextWarn = {
			bg = c.none,
			fg = c.warning,
		}
		hl.DiagnosticVirtualTextError = {
			bg = c.none,
			fg = c.error,
		}
		hl.DiagnosticVirtualTextInfo = {
			bg = c.none,
			fg = c.info,
		}

		hl.MatchParen = {
			bg = "#636161",
		}
	end,
})
