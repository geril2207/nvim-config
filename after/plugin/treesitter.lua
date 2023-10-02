-- require 'nvim-treesitter.install'.compilers = { "clang" }
require("nvim-treesitter.configs").setup({
	ensure_installed = {
		"query",
		"vim",
		"vimdoc",
		"javascript",
		"lua",
		"tsx",
		"typescript",
		"html",
		"scss",
		"css",
		"json",
		"prisma",
		"markdown",
		"markdown_inline",
		"python",
		"go",
		"rust",
		"dot",
		"bash",
    "comment"
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
