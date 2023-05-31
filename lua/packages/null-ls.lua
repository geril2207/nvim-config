-- local null_ls = require("null-ls")
-- null_ls.setup({
-- 	sources = {
-- 		null_ls.builtins.formatting.prettierd
-- 	},
-- 	on_attach = function(client, bufnr)
-- 		if client.server_capabilities.documentFormattingProvider then
-- 			vim.cmd("nnoremap <silent><buffer> <Leader>f :lua vim.lsp.buf.format({})<CR>")
--
-- 		end
-- 	end,
-- })
--
local null_ls = require("null-ls")

-- local group = vim.api.nvim_create_augroup("lsp_format_on_save", { clear = false })
-- local event = "BufWritePre" -- or "BufWritePost"
-- local async = event == "BufWritePost"

null_ls.setup({
	root_dir = function() return vim.loop.cwd() end,
	sources = {
		null_ls.builtins.formatting.black,
		null_ls.builtins.formatting.prettier,
		null_ls.builtins.formatting.stylua,
		null_ls.builtins.formatting.rustfmt
	},
	on_attach = function(client, bufnr)
		if client.supports_method("textDocument/formatting") then
			vim.keymap.set("n", "<Leader>f", function()
				vim.lsp.buf.format({ bufnr = vim.api.nvim_get_current_buf(), async = true })
			end, { buffer = bufnr, desc = "[lsp] format" })
			vim.keymap.set("n", "<A-F>", function()
				vim.lsp.buf.format({ bufnr = vim.api.nvim_get_current_buf(), async = true })
			end, { buffer = bufnr, desc = "[lsp] format" })

			-- format on save
			--   vim.api.nvim_clear_autocmds({ buffer = bufnr, group = group })
			--   vim.api.nvim_create_autocmd(event, {
			--     buffer = bufnr,
			--     group = group,
			--     callback = function()
			--       vim.lsp.buf.format({ bufnr = bufnr, async = async })
			--     end,
			--     desc = "[lsp] format on save",
			-- })
		end

		if client.supports_method("textDocument/rangeFormatting") then
			vim.keymap.set("x", "<Leader>f", function()
				vim.lsp.buf.format({ bufnr = vim.api.nvim_get_current_buf(), async = true })
			end, { buffer = bufnr, desc = "[lsp] format" })
			vim.keymap.set("n", "<A-F>", function()
				vim.lsp.buf.format({ bufnr = vim.api.nvim_get_current_buf(), async = true })
			end, { buffer = bufnr, desc = "[lsp] format" })
		end
	end,
})


-- local prettier = require("prettier")
--
-- prettier.setup({
-- 	bin = 'prettier', -- or `'prettierd'` (v0.22+)
-- 	filetypes = {
-- 		"css",
-- 		"graphql",
-- 		"html",
-- 		"javascript",
-- 		"javascriptreact",
-- 		"json",
-- 		"less",
-- 		"markdown",
-- 		"scss",
-- 		"typescript",
-- 		"typescriptreact",
-- 		"yaml",
-- 	},
-- 	cli_options = {
-- 		-- https://prettier.io/docs/en/cli.html#--config-precedence
-- 		config_precedence = "prefer-file", -- or "cli-override" or "file-override"
-- 		tab_width = 2,
-- 		use_tabs = false
-- 	},
-- })
