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
		-- update_root = true
	},
	view = {
		width = 35,
	},
	git = {
		enable = true,
		ignore = false,
	},
	filters = {
		dotfiles = false,
		git_clean = false,
		no_buffer = false,
		custom = { "^.git$" },
		exclude = {},
	},
})

local function open_nvim_tree(data)
	-- buffer is a [No Name]
	local no_name = data.file == "" and vim.bo[data.buf].buftype == ""

	-- buffer is a directory
	local directory = vim.fn.isdirectory(data.file) == 1

	if not no_name and not directory then
		require("nvim-tree.api").tree.toggle({ focus = false })
		return
	end

	-- change to the directory
	if directory then
		vim.cmd.cd(data.file)
	end

	-- open the tree
	require("nvim-tree.api").tree.open()
end
vim.api.nvim_create_autocmd({ "VimEnter" }, { callback = open_nvim_tree })
