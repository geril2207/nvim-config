local null_ls = require("null-ls")
null_ls.setup({
	sources = {
		null_ls.builtins.formatting.prettierd
	},
	on_attach = function(client, bufnr)
		if client.server_capabilities.documentFormattingProvider then
			vim.cmd("nnoremap <silent><buffer> <Leader>f :lua vim.lsp.buf.format({})<CR>")

		end
	end,
})



local prettier = require("prettier")

prettier.setup({
	bin = 'prettierd', -- or `'prettierd'` (v0.22+)
	filetypes = {
		"css",
		"graphql",
		"html",
		"javascript",
		"javascriptreact",
		"json",
		"less",
		"markdown",
		"scss",
		"typescript",
		"typescriptreact",
		"yaml",
	},
})
