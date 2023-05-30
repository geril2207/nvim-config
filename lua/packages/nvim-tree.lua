require 'nvim-web-devicons'.setup {
	override = {
		["gql"] = {
			icon = "",
			color = "#e535ab",
			cterm_color = "199",
			name = "GQL"
		}
	}
}
-- disable netrw at the very start of your init.lua (strongly advised)
vim.g.loaded = 1
vim.g.loaded_netrwPlugin = 1

-- empty setup using defaults
require("nvim-tree").setup({
	hijack_netrw = true,
	disable_netrw = true,
	open_on_setup_file = true,
	update_focused_file = {
		enable = true,
		-- update_root = true
	},
	view = {
		width = 35
	}
})


local function open_nvim_tree()

  -- open the tree
  require("nvim-tree.api").tree.open()
end
vim.api.nvim_create_autocmd({ "VimEnter" }, { callback = open_nvim_tree })
