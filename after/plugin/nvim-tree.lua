require("nvim-web-devicons").setup({
	override = {
		["gql"] = {
			icon = "",
			color = "#e535ab",
			cterm_color = "199",
			name = "GQL",
		},
	},
})
-- disable netrw at the very start of your init.lua (strongly advised)
vim.g.loaded = 1
vim.g.loaded_netrwPlugin = 1

-- empty setup using defaults
require("nvim-tree").setup({
	hijack_netrw = true,
	disable_netrw = true,
	update_focused_file = {
		enable = true,
	},
	view = {
		width = 35,
	},
	git = {
		enable = false,
		ignore = false,
	},
	filters = {
		dotfiles = false,
		custom = { "^.git$", "node_modules" },
		exclude = {},
	},
	renderer = {
		root_folder_label = false,
	},
})

local function open_nvim_tree(data)
	local directory = vim.fn.isdirectory(data.file) == 1
	local real_file = vim.fn.filereadable(data.file) == 1

	if directory then
		vim.cmd.cd(data.file)
	end

	if real_file then
		require("nvim-tree.api").tree.toggle({ focus = false, find_file = true })
		return
	end

	require("nvim-tree.api").tree.open()
end
vim.api.nvim_create_autocmd({ "VimEnter" }, { callback = open_nvim_tree })
