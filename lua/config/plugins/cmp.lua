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
	preselect = cmp.PreselectMode.None,
	completion = {
		completeopt = "menu,menuone,noinsert",
	},
	snippet = {
		expand = function(args)
			luasnip.lsp_expand(args.body)
		end,
	},
	mapping = cmp.mapping.preset.insert({
		["<C-p>"] = function()
			if cmp.visible() then
				cmp.select_prev_item(cmp_select)
			else
				cmp.complete()
			end
		end,
		["<C-n>"] = function()
			if cmp.visible() then
				cmp.select_next_item(cmp_select)
			else
				cmp.complete()
			end
		end,
		["<C-k>"] = cmp.mapping.scroll_docs(-4),
		["<C-j>"] = cmp.mapping.scroll_docs(4),
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
		{ name = "buffer", keyword_length = 3 },
	}),
})
