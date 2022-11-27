-- luasnip setup
local luasnip = require 'luasnip'
local lspkind = require("lspkind")
-- nvim-cmp setup
local cmp = require 'cmp'
cmp.setup {
	completion = {
		completeopt = 'menu,menuone,noinsert'
	},
	snippet = {
		expand = function(args)
			luasnip.lsp_expand(args.body)
		end,
	},
	
	mapping = cmp.mapping.preset.insert({
		['<C-d>'] = cmp.mapping.scroll_docs(-4),
		['<C-f>'] = cmp.mapping.scroll_docs(4),
		['<C-r>'] = cmp.mapping.complete(),

		['<CR>'] = cmp.mapping.confirm {
			behavior = cmp.ConfirmBehavior.Replace,
			select = true,
		},
		['<Tab>'] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_next_item()
			elseif luasnip.expand_or_jumpable() then
				luasnip.expand_or_jump()
			else
				fallback()
			end
		end, { 'i', 's' }),
		['<S-Tab>'] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_prev_item()
			elseif luasnip.jumpable(-1) then
				luasnip.jump(-1)
			else
				fallback()
			end
		end, { 'i', 's' }),
	}),
	formatting = {
		format = lspkind.cmp_format({
			mode = 'symbol', -- show only symbol annotations
			maxwidth = 50, -- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)
			ellipsis_char = '...', -- when popup menu exceed maxwidth, the truncated part would show ellipsis_char instead (must define maxwidth first)

			before = function(entry, vim_item)
				return vim_item
			end
		})
	},
	sources = {
		{ name = 'luasnip' },
		{ name = 'nvim_lsp' },
		{ name = 'path' },
	},
}
require('nvim-autopairs').setup({
	disable_filetype = { "TelescopePrompt", "vim" },
})
local saga = require('lspsaga')

saga.init_lsp_saga({
	finder_action_keys = {
		open = 'o',
		quit = 'q',
		scroll_down = '<C-f>',
		scroll_up = '<C-d>', -- quit can be a table
	},
	code_action_keys = {
		quit = 'q',
		exec = '<CR>',
	},
	definition_action_keys = {
		quit = 'q',
	},
})
require('nvim-ts-autotag').setup()
require("mason").setup({
	ui = {
		icons = {
			package_installed = "✓",
			package_pending = "➜",
			package_uninstalled = "✗"
		}
	}
})



local capabilities = vim.lsp.protocol.make_client_capabilities()

capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

local lspconfig = require('lspconfig')
local on_attach = function(client, bufnr)
	-- Enable completion triggered by <c-x><c-o>
	vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

	-- Mappings.
	-- See `:help vim.lsp.*` for documentation on any of the below functions
	local bufopts = { noremap = true, silent = true, buffer = bufnr }
	vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
	vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
	vim.keymap.set('n', '<leader>d', vim.lsp.buf.definition, bufopts)
end

-- Enable some language servers with the additional completion capabilities offered by nvim-cmp
local servers = { 'clangd', 'rust_analyzer', 'pyright', 'tsserver', 'eslint', 'graphql', 'sumneko_lua', 'html', 'cssls', 'eslint_d', 'cssmodules_ls','astro','tailwindcss' }
for _, lsp in ipairs(servers) do
	lspconfig[lsp].setup {
		on_attach = on_attach,
		capabilities = capabilities,
	}
end
