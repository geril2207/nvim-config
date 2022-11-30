require("gruvbox").setup({
	undercurl = true,
	underline = true,
	bold = false,
	italic = false,
	strikethrough = true,
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
	transparent_mode = true,
})
vim.g.catppuccin_flavour = "macchiato" -- latte, frappe, macchiato, mocha
require("catppuccin").setup({
	transparent_background = true,
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


require('lualine').setup {
	options = {
		icons_enabled = true,
		theme = 'auto',
		component_separators = { left = '', right = '' },
		section_separators = { left = '', right = '' },
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
		}
	},
	sections = {
		lualine_a = { 'mode' },
		lualine_b = { 'branch', 'diff', 'diagnostics' },
		lualine_c = { 'filename' },
		lualine_x = { 'encoding', 'fileformat', 'filetype' },
		lualine_y = { 'progress' },

		lualine_z = { 'location' }
	},
	inactive_sections = {
		lualine_a = {},
		lualine_b = {},
		lualine_c = { 'filename' },
		lualine_x = { 'location' },
		lualine_y = {},
		lualine_z = {}
	},
	tabline = {},
	winbar = {},
	inactive_winbar = {},
	extensions = {}
}

-- Lua
require('onedark').setup {
	-- Main options --
	style = 'dark', -- Default theme style. Choose between 'dark', 'darker', 'cool', 'deep', 'warm', 'warmer' and 'light'
	transparent = true, -- Show/hide background
	term_colors = true, -- Change terminal color as per the selected theme style
	ending_tildes = false, -- Show the end-of-buffer tildes. By default they are hidden
	cmp_itemkind_reverse = false, -- reverse item kind highlights in cmp menu

	-- toggle theme style ---
	toggle_style_key = nil, -- keybind to toggle theme style. Leave it nil to disable it, or set it to a string, for example "<leader>ts"
	toggle_style_list = { 'dark', 'darker', 'cool', 'deep', 'warm', 'warmer', 'light' }, -- List of styles to toggle between

	-- Change code style ---
	-- Options are italic, bold, underline, none
	-- You can configure multiple style with comma seperated, For e.g., keywords = 'italic,bold'
	code_style = {
		comments = 'none',
		keywords = 'none',
		functions = 'none',
		strings = 'none',
		variables = 'none'
	},

	-- Lualine options --
	lualine = {
		transparent = true, -- lualine center bar transparency
	},
}


require("onedarkpro").setup({
	highlights = {}, -- Override default highlight and/or filetype groups
	styles = { -- Choose from "bold,italic,underline"
		types = "NONE", -- Style that is applied to types
		numbers = "NONE", -- Style that is applied to numbers
		strings = "NONE", -- Style that is applied to strings
		comments = "NONE", -- Style that is applied to comments
		keywords = "NONE", -- Style that is applied to keywords
		constants = "NONE", -- Style that is applied to constants
		functions = "NONE", -- Style that is applied to functions
		operators = "NONE", -- Style that is applied to operators
		variables = "NONE", -- Style that is applied to variables
		conditionals = "NONE", -- Style that is applied to conditionals
		virtual_text = "NONE", -- Style that is applied to virtual text
	},
	options = {
		bold = false, -- Use bold styles?
		italic = false, -- Use italic styles?
		underline = true, -- Use underline styles?
		undercurl = true, -- Use undercurl styles?

		cursorline = false, -- Use cursorline highlighting?
		transparency = true, -- Use a transparent background?
		terminal_colors = true, -- Use the theme's colors for Neovim's :terminal?
		window_unfocused_color = false, -- When the window is out of focus, change the normal background?
	}
})

require("tokyonight").setup({
	-- your configuration comes here
	-- or leave it empty to use the default settings
	style = "storm", -- The theme comes in three styles, `storm`, `moon`, a darker variant `night` and `day`
	transparent = true, -- Enable this to disable setting the background color
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
			fg = c.hint
		}
		hl.DiagnosticVirtualTextWarn = {
			bg = c.none,
			fg = c.warning
		}
		hl.DiagnosticVirtualTextError = {
			bg = c.none,
			fg = c.error
		}
		hl.DiagnosticVirtualTextInfo = {
			bg = c.none,
			fg = c.info
		}

		hl.MatchParen = {
			bg = "#636161"
		}
	end
})


vim.cmd [[colorscheme gruvbox]]
vim.cmd("autocmd VimEnter * hi Normal ctermbg=NONE guibg=NONE")
