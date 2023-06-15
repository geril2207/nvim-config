-- luasnip setup
local luasnip = require("luasnip")
local lspkind = require("lspkind")

local cmp = require("cmp")

luasnip.setup({
	region_check_events = "InsertEnter",
	delete_check_events = "TextChanged,InsertLeave",
})

require("luasnip.loaders.from_vscode").lazy_load()
luasnip.filetype_extend("typescript", { "typescriptreact", "javascript" })
luasnip.filetype_extend("javascript", { "typescript", "javascriptreact" })

local function toggle_completion_menu()
	if cmp.visible() then
		cmp.close()
	else
		cmp.complete()
	end
end

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
		["<C-d>"] = cmp.mapping.scroll_docs(-4),
		["<C-f>"] = cmp.mapping.scroll_docs(4),
		["<C-Space>"] = cmp.mapping(toggle_completion_menu, { "i", "c" }),
		["<C-s>"] = cmp.mapping(toggle_completion_menu, { "i", "c" }),
		["<CR>"] = cmp.mapping.confirm({
			behavior = cmp.ConfirmBehavior.Replace,
			select = false,
		}),
		["<Tab>"] = cmp.mapping(function(fallback)
			if cmp.visible() and cmp.get_selected_entry() then
				cmp.confirm({
					behavior = cmp.ConfirmBehavior.Replace,
					select = false,
				})
			elseif luasnip.expand_or_jumpable() then
				luasnip.expand_or_jump()
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
		format = lspkind.cmp_format({
			mode = "symbol_text", -- show only symbol annotations
			maxwidth = 50, -- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)
			ellipsis_char = "...", -- when popup menu exceed maxwidth, the truncated part would show ellipsis_char instead (must define maxwidth first)

			before = function(entry, vim_item)
				return vim_item
			end,
		}),
	},
	sources = {
		{ name = "nvim_lsp" },
		{ name = "luasnip" },
		{ name = "path" },
		{ name = "buffer" },
	},
})
require("nvim-autopairs").setup({
	disable_filetype = { "TelescopePrompt", "vim" },
})
local saga = require("lspsaga")

saga.setup({
	finder_action_keys = {
		open = "o",
		quit = "q",
		scroll_down = "<C-f>",
		scroll_up = "<C-d>", -- quit can be a table
	},
	code_action_keys = {
		quit = "q",
		exec = "<CR>",
	},
	definition_action_keys = {
		quit = "q",
	},
	beacon = {
		enable = false,
	},
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
	"emmet_ls",
	"tailwindcss",
	"eslint",
	"pylsp",
	"graphql",
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
		"graphql",
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
	}, bufnr)

	-- Mappings.
	-- See `:help vim.lsp.*` for documentation on any of the below functions
	local bufopts = { noremap = true, silent = true, buffer = bufnr }
	vim.keymap.set("n", "gD", vim.lsp.buf.declaration, bufopts)
	vim.keymap.set("n", "gd", vim.lsp.buf.definition, bufopts)
	vim.keymap.set("n", "<leader>d", vim.lsp.buf.definition, bufopts)
	vim.keymap.set("n", "<leader>f", formatFile, bufopts)
	vim.keymap.set("n", "<A-F>", formatFile, bufopts)
	vim.keymap.set("n", "<Leader>k", function()
		vim.lsp.buf.signature_help()
	end, { silent = true, noremap = true, desc = "toggle signature" })
end

-- Enable some language servers with the additional completion capabilities offered by nvim-cmp
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
