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

local nmap = require("utils").nmap
local imap = require("utils").imap
local nvmap = require("utils").nvmap

local on_attach = function(client, bufnr)
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
	nmap("gD", vim.lsp.buf.declaration, bufopts)
	nmap("gh", vim.lsp.buf.hover, bufopts)
	nmap("gi", ":Telescope lsp_implementations<CR>", bufopts)
	nmap("<leader>d", vim.lsp.buf.definition, bufopts)
	nmap("gd", vim.lsp.buf.definition, bufopts)
	nmap("gt", vim.lsp.buf.type_definition, bufopts)
	nmap("<leader>k", vim.lsp.buf.signature_help, bufopts)
	nmap("[e", vim.diagnostic.goto_prev, bufopts)
	nmap("<leader>r", vim.lsp.buf.rename, bufopts)
	nmap("]e", vim.diagnostic.goto_next, bufopts)
	nvmap("<A-F>", formatFile, bufopts)
	nvmap("<leader>f", formatFile, bufopts)
	nvmap("<leader>la", vim.lsp.buf.code_action, bufopts)
	imap("<A-w>", vim.lsp.buf.signature_help, bufopts)

	nmap("<leader>ld", function()
		vim.diagnostic.open_float({
			scope = "line",
			source = "if_many",
		})
	end)
end

return on_attach
