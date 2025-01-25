--- HACK: Override `vim.lsp.util.stylize_markdown` to use Treesitter.
---@param bufnr integer
---@param contents string[]
---@param opts table
---@return string[]
---@diagnostic disable-next-line: duplicate-set-field
vim.lsp.util.stylize_markdown = function(bufnr, contents, opts)
	contents = vim.lsp.util._normalize_markdown(contents, {
		width = vim.lsp.util._make_floating_popup_size(contents, opts),
	})
	vim.bo[bufnr].filetype = "markdown"
	vim.treesitter.start(bufnr)
	vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, contents)

	return contents
end

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

-- local methods = vim.lsp.protocol.Methods
local map_utils = require("utils.map")
local map_tbl = map_utils.map_tbl

--- Sets up LSP keymaps and autocommands for the given buffer.
---@param client vim.lsp.Client
---@param bufnr integer
local on_attach = function(client, bufnr)
	-- Disable formatting for some servers to use external utils like prettier
	for _, server in ipairs({
		"volar",
		"ts_ls",
		"vtsls",
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
	}) do
		if client.name == server then
			client.server_capabilities.documentFormattingProvider = false
		end
	end

	-- Highlight references when holding
	--[[ if client.supports_method(methods.textDocument_documentHighlight) then
		local under_cursor_highlights_group = vim.api.nvim_create_augroup("mariasolos/cursor_highlights", { clear = false })
		vim.api.nvim_create_autocmd({ "CursorHold", "InsertLeave" }, {
			group = under_cursor_highlights_group,
			desc = "Highlight references under the cursor",
			buffer = bufnr,
			callback = vim.lsp.buf.document_highlight,
		})
		vim.api.nvim_create_autocmd({ "CursorMoved", "InsertEnter", "BufLeave" }, {
			group = under_cursor_highlights_group,
			desc = "Clear highlight references",
			buffer = bufnr,
			callback = vim.lsp.buf.clear_references,
		})
	end ]]

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
	local builtin = require("telescope.builtin")
	map_tbl({
		i = {
			["<A-w>"] = { vim.lsp.buf.signature_help, bufopts },
		},

		n = {
			["gD"] = { vim.lsp.buf.declaration, bufopts },
			-- ["gh"] = { vim.lsp.buf.hover, bufopts },
			["<leader>lh"] = { vim.lsp.buf.hover, bufopts },
			["gi"] = { ":Telescope lsp_implementations<CR>", bufopts },

			-- ["<leader>d"] = { vim.lsp.buf.definition, bufopts },
			-- ["gd"] = { vim.lsp.buf.definition, bufopts },
			["<leader>d"] = { builtin.lsp_definitions, bufopts },
			["gd"] = { builtin.lsp_definitions, bufopts },
			-- ["gd"] = { vim.lsp.buf.definition, bufopts },
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
					source = "if_many",
				})
			end,
		},
	})
end

return {
	{
		"nvimtools/none-ls.nvim",
		event = "VeryLazy",
		dev = true,
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
					"ts_ls",
					"vtsls",
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

			local capabilities = vim.tbl_deep_extend(
				"force",
				vim.lsp.protocol.make_client_capabilities(),
				-- nvim-cmp supports additional completion capabilities, so broadcast that to servers.
				require("cmp_nvim_lsp").default_capabilities()
			)
			local lspconfig = require("lspconfig")

			local servers = {
				zls = {},
				gleam = {
					root_dir = get_cwd,
				},
				ocamllsp = {
					root_dir = get_cwd,
				},
				ts_ls = {
					disabled = true,
					root_dir = get_cwd,
				},
				vtsls = {
					root_dir = get_cwd,
					settings = {
						typescript = { format = { enable = false } },
						javascript = { format = { enable = false } },
					},
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
					disabled = true,
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
			-- vim.lsp.handlers["textDocument/definition"] = function(_, result)
			-- 	if not result or vim.tbl_isempty(result) then
			-- 		--print("[LSP] Could not find definition")
			-- 		return
			-- 	end
			--
			-- 	if vim.islist(result) then
			-- 		vim.lsp.util.jump_to_location(result[1], "utf-8")
			-- 	else
			-- 		vim.lsp.util.jump_to_location(result, "utf-8")
			-- 	end
			-- end

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
				enabled = false,
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
			{ "ray-x/lsp_signature.nvim", dev = true },
			"b0o/schemastore.nvim",
		},
	},
}
