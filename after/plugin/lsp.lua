-- luasnip setup
local luasnip = require("luasnip")

local cmp = require("cmp")

local function toggle_completion_menu()
	if cmp.visible() then
		cmp.close()
	else
		cmp.complete()
	end
end

local cmp_select = { behavior = cmp.SelectBehavior.Select }
local confirm_options = {
	behavior = cmp.ConfirmBehavior.Insert,
	select = false,
}

cmp.setup({
	completion = {
		completeopt = "menu,menuone,noinsert",
	},
	snippet = {
		expand = function(args)
			luasnip.lsp_expand(args.body)
		end,
	},
	mapping = cmp.mapping.preset.insert({
		["<C-p>"] = cmp.mapping.select_prev_item(cmp_select),
		["<C-n>"] = cmp.mapping.select_next_item(cmp_select),
		["<C-d>"] = cmp.mapping.scroll_docs(-4),
		["<C-f>"] = cmp.mapping.scroll_docs(4),
		["<C-Space>"] = cmp.mapping(toggle_completion_menu, { "i", "c" }),
		["<C-s>"] = cmp.mapping(toggle_completion_menu, { "i", "c" }),
		["<CR>"] = cmp.mapping.confirm(confirm_options),
		["<Tab>"] = cmp.mapping(function(fallback)
			if cmp.visible() and cmp.get_selected_entry() then
				cmp.confirm(confirm_options)
			elseif luasnip.jumpable(1) then
				luasnip.jump(1)
			elseif luasnip.expandable() then
				luasnip.expand()
			else
				fallback()
			end
		end, { "i", "s" }),
		["<S-Tab>"] = cmp.mapping(function(fallback)
			if luasnip.jumpable(-1) then
				luasnip.jump(-1)
			elseif cmp.visible() then
				cmp.select_prev_item()
			else
				fallback()
			end
		end, { "i", "s" }),
	}),
	formatting = {
		fields = { "kind", "abbr", "menu" },
		format = function(entry, vim_item)
			local kind = require("lspkind").cmp_format({
				mode = "symbol",
				maxwidth = 50,
				preset = "codicons",
				ellipsis_char = "...",
			})(entry, vim_item)
			local strings = vim.split(kind.kind, "%s", { trimempty = true })
			kind.kind = strings[1] or ""
			kind.menu = strings[2] or ""

			return kind
		end,
	},
	sources = cmp.config.sources({
		{ name = "nvim_lsp" },
		{ name = "luasnip" },
		{ name = "path" },
		{ name = "buffer" },
	}),
})

require("nvim-autopairs").setup({
	disable_filetype = { "TelescopePrompt", "vim" },
})

require("mason").setup({
	ui = {
		icons = {
			package_installed = "✓",
			package_pending = "➜",
			package_uninstalled = "✗",
		},
	},
})

local servers = {
	"tsserver",
	"html",
	"cssls",
	"cssmodules_ls",
	"stylelint_lsp",
	"jsonls",
	"clangd",
	"tailwindcss",
	"eslint",
	"pylsp",
	-- "graphql",
	"lua_ls",
	"astro",
	"yamlls",
	"dockerls",
	"prismals",
	"gopls",
}

require("mason-lspconfig").setup({
	ensure_installed = {
		"tsserver",
		"html",
		"cssls",
		"cssmodules_ls",
		"stylelint_lsp",
		"jsonls",
		"clangd",
		"emmet_ls",
		"tailwindcss",
		"eslint",
		-- "pylsp",
		-- "graphql",
		"lua_ls",
		"astro",
		"yamlls",
		"dockerls",
		"prismals",
		"gopls",
		"rust_analyzer",
	},
})

local capabilities = vim.lsp.protocol.make_client_capabilities()

capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

local function formatFile()
	vim.lsp.buf.format({
		async = true,
	})
end

local servers_formatting_disable = {
	"tsserver",
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
local lspconfig = require("lspconfig")
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
		bind = true,
		doc_lines = 0,
		handler_opts = {
			border = "single", -- double, rounded, single, shadow, none, or a table of borders
		},
		hint_enable = false,
		toggle_key = "<A-s>",
		floating_window = false,
		floating_window_off_x = -1,
	}, bufnr)

	-- Mappings.lsp
	-- See `:help vim.lsp.*` for documentation on any of the below functions
	local bufopts = { noremap = true, silent = true, buffer = bufnr }
	vim.keymap.set("n", "gD", vim.lsp.buf.declaration, bufopts)
	vim.keymap.set("n", "gh", vim.lsp.buf.hover, bufopts)
	vim.keymap.set("n", "<leader>f", formatFile, bufopts)
	vim.keymap.set("n", "<A-F>", formatFile, bufopts)
	vim.keymap.set("i", "<A-w>", vim.lsp.buf.signature_help, bufopts)
	vim.keymap.set("n", "<Leader>k", vim.lsp.buf.signature_help, bufopts)
	vim.keymap.set("n", "[e", vim.diagnostic.goto_prev, bufopts)
	vim.keymap.set("n", "]e", vim.diagnostic.goto_next, bufopts)
end

for _, lsp in ipairs(servers) do
	lspconfig[lsp].setup({
		on_attach = on_attach,
		capabilities = capabilities,
		root_dir = function()
			return vim.loop.cwd()
		end,
	})
end

lspconfig.rust_analyzer.setup({
	on_attach = on_attach,
	capabilities = capabilities,
	root_dir = function()
		return vim.loop.cwd()
	end,
	settings = {
		["rust-analyzer"] = {
			rustfmt = {
				-- extraArgs = { "--config", "tab_spaces=2" },
			},
		},
	},
})

lspconfig.emmet_ls.setup({
	on_attach = on_attach,
	capabilities = capabilities,
	root_dir = function()
		return vim.loop.cwd()
	end,
	filetypes = {
		"astro",
		"css",
		"eruby",
		"html",
		"htmldjango",
		"less",
		"pug",
		"sass",
		"scss",
		"svelte",
		"vue",
	},
})

-- Diagnostic symbols in the sign column (gutter)
local signs = { Error = " ", Warn = " ", Hint = "󱌹 ", Info = " " }

for type, icon in pairs(signs) do
	local hl = "DiagnosticSign" .. type
	vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
end

local diagnostic_config = {
	update_in_insert = false,
	severity_sort = true,
	underline = true,
	signs = {
		severity_limit = "Hint",
	},
	virtual_text = {
		severity_limit = "Warning",
	},
}

local null_ls = require("null-ls")

null_ls.setup({
	root_dir = function()
		return vim.loop.cwd()
	end,
	diagnostic_config = diagnostic_config,
	update_in_insert = false,
	sources = {
		null_ls.builtins.formatting.black,
		null_ls.builtins.formatting.prettier,
		null_ls.builtins.formatting.stylua,
		null_ls.builtins.diagnostics.pylint,
	},
})

vim.lsp.handlers["textDocument/publishDiagnostics"] =
	vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, diagnostic_config)

vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
	border = "single",
})

vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
	border = "single",
})

vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
	pattern = { "**/node_modules/**", "node_modules", "/node_modules/*" },
	callback = function()
		vim.diagnostic.disable(0)
	end,
})
