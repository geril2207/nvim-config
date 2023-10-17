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
	}, {
		{ name = "buffer", keyword_length = 3 },
	}),
	sorting = {
		-- TODO: Would be cool to add stuff like "See variable names before method names" in rust, or something like that.
		comparators = {
			cmp.config.compare.exact,
			cmp.config.compare.score,
			cmp.config.compare.offset,
			cmp.config.compare.locality,
			cmp.config.compare.length,

			-- copied from cmp-under, but I don't think I need the plugin for this.
			-- I might add some more of my own.
			function(entry1, entry2)
				local _, entry1_under = entry1.completion_item.label:find("^_+")
				local _, entry2_under = entry2.completion_item.label:find("^_+")
				entry1_under = entry1_under or 0
				entry2_under = entry2_under or 0
				if entry1_under > entry2_under then
					return false
				elseif entry1_under < entry2_under then
					return true
				end
			end,

			cmp.config.compare.kind,
			cmp.config.compare.sort_text,
			cmp.config.compare.order,
		},
	},
})
