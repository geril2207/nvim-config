-- require 'nvim-treesitter.install'.compilers = { "clang" }
local function disable()
	local is_disable = false
	local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(vim.api.nvim_get_current_buf()))

	if ok and stats ~= nil and stats.size > 1000 * 100 then
		is_disable = true
		-- return true
	end

	return is_disable
end

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
		"comment",
	},
	sync_install = false,
	indent = {
		enable = true,
		disable = { "rust" },
	},

	highlight = {
		enable = true,
		additional_vim_regex_highlighting = false,
		disable = disable,
	},

	textobjects = {
		select = {
			enable = true,
			disable = disable,
			keymaps = {
				["af"] = "@function.outer",
				["if"] = "@function.inner",
				["ac"] = "@class.outer",
			},
		},
	},

	autotag = {
		enable = true,
		disable = disable,
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
		disable = disable,
		enable_autocmd = false,
	},
})
