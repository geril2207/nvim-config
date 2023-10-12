local function formatFile()
	vim.lsp.buf.format({
		async = true,
	})
end

local servers_formatting_disable = {
	"volar",
	"tsserver",
	"biome",
	"html",
	"cssls",
	"cssmodules_ls",
	"stylelint_lsp",
	"jsonls",
	"emmet_ls",
	"tailwindcss",
	"eslint",
	"pylsp",
	"graphql",
	"lua_ls",
	"astro",
}

local map = require("utils").map

local on_attach = function(client, bufnr)
	-- Enable completion triggered by <c-x><c-o>
	vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")
	-- Disable formatting for some servers to use external utils like prettier
	for _, server in ipairs(servers_formatting_disable) do
		if client.name == server then
			client.server_capabilities.documentFormattingProvider = false
		end
	end
	require("lsp_signature").on_attach({
		bind = false,
		doc_lines = 5,
		handler_opts = {
			border = "single", -- double, rounded, single, shadow, none, or a table of borders
		},
		hint_enable = true,
		hint_prefix = "",
		toggle_key = "<A-s>",
		select_signature_key = "<A-n>", -- cycle to next signature, e.g. '<M-n>' function overloading
		floating_window = false,
	}, bufnr)

	-- Mappings.lsp
	-- See `:help vim.lsp.*` for documentation on any of the below functions
	local bufopts = { noremap = true, silent = true, buffer = bufnr }
	map("n", "gD", vim.lsp.buf.declaration, bufopts)
	map("n", "gh", vim.lsp.buf.hover, bufopts)
	map("n", "gi", ":Telescope lsp_implementations<CR>", bufopts)
	map("n", "<leader>d", vim.lsp.buf.definition, bufopts)
	map("n", "gd", vim.lsp.buf.definition, bufopts)
	map("n", "gt", vim.lsp.buf.type_definition, bufopts)
	map({ "n", "v" }, "<leader>f", formatFile, bufopts)
	map({ "n", "v" }, "<A-F>", formatFile, bufopts)
	map("i", "<A-w>", vim.lsp.buf.signature_help, bufopts)
	map("n", "<leader>k", vim.lsp.buf.signature_help, bufopts)
	map("n", "[e", vim.diagnostic.goto_prev, bufopts)
	map("n", "<leader>r", vim.lsp.buf.rename, bufopts)
	map("n", "]e", vim.diagnostic.goto_next, bufopts)
	map({ "n", "v" }, "<leader>la", vim.lsp.buf.code_action, bufopts)

	map("n", "<leader>ld", function()
		vim.diagnostic.open_float({
			scope = "line",
			source = "if_many",
		})
	end)
end

return on_attach
