--
local null_ls = require("null-ls")

null_ls.setup({
	root_dir = function()
		return vim.loop.cwd()
	end,
	sources = {
		null_ls.builtins.formatting.black,
		null_ls.builtins.formatting.prettier,
		null_ls.builtins.formatting.stylua,
	},
})
vim.lsp.set_log_level("debug")
