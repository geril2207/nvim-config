-- require 'nvim-treesitter.install'.compilers = { "clang" }
require("nvim-treesitter.configs").setup({
	ensure_installed = {
		"javascript",
		"lua",
		"tsx",
		"typescript",
		"scss",
		"css",
		"json",
		"dot",
		"prisma",
		"markdown",
		"markdown_inline",
		"python",
		"go",
		"rust",
	},
	sync_install = false,
	indent = {
		enable = true,
		disable = { "rust" },
	},

	highlight = {
		enable = true,
		additional_vim_regex_highlighting = false,
	},

	textobjects = {
		select = {
			enable = true,
			keymaps = {
				["af"] = "@function.outer",
				["if"] = "@function.inner",
				["ac"] = "@class.outer",
			},
		},
		move = {
			enable = true,
			set_jumps = true,

			goto_next_start = {
				["]p"] = "@parameter.inner",
				["]m"] = "@function.outer",
				["]]"] = "@class.outer",
			},
			goto_next_end = {
				["]M"] = "@function.outer",
				["]["] = "@class.outer",
			},
			goto_previous_start = {
				["[p"] = "@parameter.inner",
				["[m"] = "@function.outer",
				["[["] = "@class.outer",
			},
			goto_previous_end = {
				["[M"] = "@function.outer",
				["[]"] = "@class.outer",
			},
		},
	},

	autotag = {
		enable = true,
		enable_close_on_slash = false,
		filetypes = {
			"htmldjango",
			"html",
			"javascript",
			"typescript",
			"javascriptreact",
			"typescriptreact",
			"svelte",
			"vue",
			"tsx",
			"jsx",
			"rescript",
			"xml",
			"php",
			"markdown",
			"glimmer",
			"handlebars",
			"hbs",
		},
	},

	context_commentstring = {
		enable = true,
		enable_autocmd = false,
	},
})
--[[
    -- rainbowcol1 = { fg = "#FFD700"},
    -- rainbowcol2 = { fg = "#da70d6"},
    -- rainbowcol3 = { fg = "#87CEFA"},
    -- rainbowcol4 = { fg = "#FFD700"},
    -- rainbowcol5 = { fg = "#da70d6"},
    -- rainbowcol6 = { fg = "#87CEFA"},
    -- rainbowcol7 = { fg = "#FFD700"},
]]
