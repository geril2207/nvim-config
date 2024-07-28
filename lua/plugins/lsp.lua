local diagnostic_config = {
	update_in_insert = false,
	severity_sort = true,
	underline = {
		severity = {
			min = vim.diagnostic.severity.WARN,
		},
	},
	signs = {
		severity = {
			min = vim.diagnostic.severity.HINT,
		},
		text = {
			[vim.diagnostic.severity.ERROR] = " ",
			[vim.diagnostic.severity.WARN] = " ",
			[vim.diagnostic.severity.INFO] = " ",
			[vim.diagnostic.severity.HINT] = "󱌹 ",
		},
	},
	virtual_text = {
		severity = {
			min = vim.diagnostic.severity.WARN,
		},
	},
}

local get_cwd = function()
	return vim.uv.cwd()
end

local function format_file()
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

local map_utils = require("utils.map")
local map_tbl = map_utils.map_tbl

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
	map_tbl({
		i = {
			["<A-w>"] = { vim.lsp.buf.signature_help, bufopts },
		},

		n = {
			["gD"] = { vim.lsp.buf.declaration, bufopts },
			-- ["gh"] = { vim.lsp.buf.hover, bufopts },
			["<leader>lh"] = { vim.lsp.buf.hover, bufopts },
			["gi"] = { ":Telescope lsp_implementations<CR>", bufopts },
			["<leader>d"] = { vim.lsp.buf.definition, bufopts },
			["gd"] = { vim.lsp.buf.definition, bufopts },
			-- nmap("gt", vim.lsp.buf.type_definition, bufopts)
			["<leader>k"] = { vim.lsp.buf.signature_help, bufopts },
			["[e"] = { vim.diagnostic.goto_prev, bufopts },
			["<leader>r"] = { vim.lsp.buf.rename, bufopts },
			["]e"] = { vim.diagnostic.goto_next, bufopts },
			["<A-F>"] = { format_file, bufopts },
			["<leader>f"] = { format_file, bufopts },
			["<leader>la"] = { vim.lsp.buf.code_action, bufopts },

			["<leader>ld"] = function()
				vim.diagnostic.open_float({
					scope = "line",
					source = "always",
				})
			end,
		},
	})
end

return {
	{
		"nvimtools/none-ls.nvim",
		event = "VeryLazy",
		config = function()
			local null_ls = require("null-ls")

			null_ls.setup({
				root_dir = get_cwd,
				diagnostic_config = diagnostic_config,
				update_in_insert = false,
				sources = {
					null_ls.builtins.formatting.black,
					-- null_ls.builtins.formatting.prettier,
					null_ls.builtins.formatting.prettierd,
					null_ls.builtins.formatting.stylua,
					null_ls.builtins.formatting.sqlfmt,
					null_ls.builtins.formatting.ocamlformat,
				},
			})
		end,
	},
	{
		"neovim/nvim-lspconfig",
		lazy = true,
		event = "VeryLazy",
		config = function()
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

			local servers = {
				gleam = {
					root_dir = get_cwd,
				},
				ocamllsp = {
					root_dir = get_cwd,
				},
				tsserver = {
					disabled = true,
					root_dir = get_cwd,
				},
				vtsls = {
					root_dir = get_cwd,
				},
				bashls = {
					root_dir = get_cwd,
				},
				html = {},
				cssls = {},
				-- cssmodules_ls = {},
				-- stylelint_lsp = {},
				sqlls = {
					root_dir = get_cwd,
				},
				volar = {
					disabled = false,
				},
				jsonls = {
					filetypes = { "json", "jsonc" },
					settings = {
						json = {
							validate = { enable = true },
							format = { enable = false },
							-- Schemas https://www.schemastore.org
							schemas = require("schemastore").json.schemas(),
						},
					},
				},
				clangd = {},
				tailwindcss = {
					disabled = false,
				},
				eslint = {
					settings = { format = false },
				},
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
								["https://taskfile.dev/schema.json"] = "**/Taskfile.{yml,yaml}",
							},
						},
					},
				},
				dockerls = {},
				prismals = {},
				gopls = {
					root_dir = get_cwd,
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

			vim.diagnostic.config(diagnostic_config)

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

				if vim.islist(result) then
					vim.lsp.util.jump_to_location(result[1], "utf-8")
				else
					vim.lsp.util.jump_to_location(result, "utf-8")
				end
			end

			vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
				pattern = { "**/node_modules/**", "node_modules", "/node_modules/*", "dist", "build" },
				callback = function()
					vim.diagnostic.enable(false, { bufnr = 0 })
				end,
			})
		end,
		dependencies = {
			"williamboman/mason-lspconfig.nvim",
			"williamboman/mason.nvim",
			{
				"j-hui/fidget.nvim",
				event = "VeryLazy",
				branch = "legacy",
				enabled = true,
				opts = {
					text = {
						spinner = "dots",
						done = "󰸞 ",
					},
					window = {
						blend = 0,
					},
				},
			},
			"ray-x/lsp_signature.nvim",
			"b0o/schemastore.nvim",
		},
	},
}
