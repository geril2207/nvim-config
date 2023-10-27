require("mason").setup({
	ui = {
		icons = {
			package_installed = "✓",
			package_pending = "➜",
			package_uninstalled = "✗",
		},
	},
})

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
		-- "gopls",
		-- "rust_analyzer",
	},
})

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)
local lspconfig = require("lspconfig")

local on_attach = require("config.utils.on_attach")

local servers = {
	ocamllsp = {
		root_dir = function()
			return vim.loop.cwd()
		end,
	},
	tsserver = {
		root_dir = function()
			return vim.loop.cwd()
		end,
	},
	bashls = {
		root_dir = function()
			return vim.loop.cwd()
		end,
	},
	html = {},
	cssls = {},
	-- cssmodules_ls = {},
	-- stylelint_lsp = {},
	sqlls = {
		root_dir = function()
			return vim.loop.cwd()
		end,
	},
	volar = {
		disabled = true,
	},
	jsonls = {
		filetypes = { "json", "jsonc" },
		settings = {
			json = {
				-- Schemas https://www.schemastore.org
				schemas = {
					{
						fileMatch = { "package.json" },
						url = "https://json.schemastore.org/package.json",
					},
					{
						fileMatch = { "tsconfig*.json" },
						url = "https://json.schemastore.org/tsconfig.json",
					},
					{
						fileMatch = {
							".prettierrc",
							".prettierrc.json",
							"prettier.config.json",
						},
						url = "https://json.schemastore.org/prettierrc.json",
					},
					{
						fileMatch = { ".eslintrc", ".eslintrc.json" },
						url = "https://json.schemastore.org/eslintrc.json",
					},
					{
						fileMatch = { ".babelrc", ".babelrc.json", "babel.config.json" },
						url = "https://json.schemastore.org/babelrc.json",
					},
					{
						fileMatch = { "lerna.json" },
						url = "https://json.schemastore.org/lerna.json",
					},
					{
						fileMatch = { "now.json", "vercel.json" },
						url = "https://json.schemastore.org/now.json",
					},
					{
						fileMatch = {
							".stylelintrc",
							".stylelintrc.json",
							"stylelint.config.json",
						},
						url = "http://json.schemastore.org/stylelintrc.json",
					},
				},
			},
		},
	},
	clangd = {},
	tailwindcss = {
		disabled = true,
	},
	eslint = {},
	pylsp = {},
	graphql = {
		disabled = true,
	},
	rust_analyzer = {
		settings = {
			["rust-analyzer"] = {
				completion = {
					callable = {
						snippets = "none",
					},
				},
			},
		},
	},
	lua_ls = {},
	astro = {},
	yamlls = {
		settings = {
			yaml = {
				-- Schemas https://www.schemastore.org
				schemas = {
					["http://json.schemastore.org/gitlab-ci.json"] = { ".gitlab-ci.yml" },
					["https://json.schemastore.org/bamboo-spec.json"] = {
						"bamboo-specs/*.{yml,yaml}",
					},
					["https://raw.githubusercontent.com/compose-spec/compose-spec/master/schema/compose-spec.json"] = {
						"docker-compose*.{yml,yaml}",
					},
					["http://json.schemastore.org/github-workflow.json"] = ".github/workflows/*.{yml,yaml}",
					["http://json.schemastore.org/github-action.json"] = ".github/action.{yml,yaml}",
					["http://json.schemastore.org/prettierrc.json"] = ".prettierrc.{yml,yaml}",
					["http://json.schemastore.org/stylelintrc.json"] = ".stylelintrc.{yml,yaml}",
					["http://json.schemastore.org/circleciconfig"] = ".circleci/**/*.{yml,yaml}",
					["http://json.schemastore.org/lazydocker.json"] = "lazydocker/**/*.{yml,yaml}",
				},
			},
		},
	},
	dockerls = {},
	prismals = {},
	gopls = {
		settings = { gopls = { completeFunctionCalls = false } },
	},
	emmet_ls = {
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
	},
}

for server, config in pairs(servers) do
	local server_disabled = (config.disabled ~= nil and config.disabled) or false

	local default_options = {
		on_attach = on_attach,
		capabilities = capabilities,
	}

	if not server_disabled then
		lspconfig[server].setup(vim.tbl_deep_extend("force", default_options, config))
	end
end

-- Diagnostic symbols in the sign column (gutter)
local signs = { Error = " ", Warn = " ", Hint = "󱌹 ", Info = " " }

for type, icon in pairs(signs) do
	local hl = "DiagnosticSign" .. type
	vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
end

local diagnostic_config = {
	update_in_insert = false,
	severity_sort = true,
	underline = {
		severity_limit = "Warning",
	},
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
		-- null_ls.builtins.formatting.prettier,
		null_ls.builtins.formatting.prettierd,
		null_ls.builtins.formatting.stylua,
		null_ls.builtins.formatting.sqlfmt,
		null_ls.builtins.formatting.ocamlformat,
		-- null_ls.builtins.diagnostics.pylint,
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
-- Jump directly to the first available definition every time.
vim.lsp.handlers["textDocument/definition"] = function(_, result)
	if not result or vim.tbl_isempty(result) then
		--print("[LSP] Could not find definition")
		return
	end

	if vim.tbl_islist(result) then
		vim.lsp.util.jump_to_location(result[1], "utf-8")
	else
		vim.lsp.util.jump_to_location(result, "utf-8")
	end
end

vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
	pattern = { "**/node_modules/**", "node_modules", "/node_modules/*", "dist", "build" },
	callback = function()
		vim.diagnostic.disable(0)
	end,
})

-- local api = vim.api
-- ! posible need to fix in 0.10 version
-- local function open_diagnostic()
-- 	local diagnostics = vim.diagnostic.get(0)
-- 	local cursor = api.nvim_win_get_cursor(0)
--
-- 	local cursor_line = cursor[1] - 1
-- 	local cursor_col = cursor[2]
--
-- 	for _, diagnostic in ipairs(diagnostics) do
-- 		if cursor_line == diagnostic.lnum then
-- 			if cursor_col >= diagnostic.col and cursor_col <= diagnostic.end_col then
-- 				vim.diagnostic.open_float({
-- 					scope = "cursor",
-- 					focusable = false,
-- 					close_events = {
-- 						"CursorMoved",
-- 						"CursorMovedI",
-- 						"BufHidden",
-- 						"InsertCharPre",
-- 						"WinLeave",
-- 					},
-- 				})
-- 			end
-- 		end
-- 	end
-- end

-- Show diagnostics under the cursor when holding position
-- vim.api.nvim_create_augroup("lsp_diagnostics_hold", { clear = true })
-- vim.api.nvim_create_autocmd({ "CursorHold" }, {
-- 	pattern = "*",
-- 	-- pattern = "\\v(.*)(node_modules|build|dist)/.*$@<!",
-- 	callback = open_diagnostic,
-- 	group = "lsp_diagnostics_hold",
-- })
