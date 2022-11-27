-- disable netrw at the very start of your init.lua (strongly advised)
vim.g.loaded = 1
vim.g.loaded_netrwPlugin = 1

-- empty setup using defaults
 require("nvim-tree").setup({
	  hijack_netrw = true,
		disable_netrw = true, 
		open_on_setup = true,
		open_on_setup_file = true,
		update_focused_file = {
			enable = true,
			update_root = true
		}
})


