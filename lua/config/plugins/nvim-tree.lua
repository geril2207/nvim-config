vim.g.loaded = 1
vim.g.loaded_netrwPlugin = 1

local function on_attach(bufnr)
	local api = require("nvim-tree.api")

	api.events.subscribe(api.events.Event.FileCreated, function(file)
		vim.cmd("edit " .. file.fname)
	end)
	api.config.mappings.default_on_attach(bufnr)

	local function opts(desc)
		return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
	end

	vim.keymap.set("n", "l", api.node.open.edit, opts("Open"))
	vim.keymap.set("n", "t", function()
		api.node.open.edit()
		api.tree.close()
	end, opts("Open With closing"))

	vim.keymap.set("n", "sv", api.node.open.vertical, opts("Open Split: Vertical"))
	vim.keymap.set("n", "sh", api.node.open.horizontal, opts("Open Split: Horizontal"))

	local open_file_opts = require("nvim-tree.actions.node.open-file")

	vim.keymap.set("n", "st", function()
		open_file_opts.quit_on_open = not open_file_opts.quit_on_open
	end, opts("NvimTree Always Open Toggle State"))
end

-- empty setup using defaults
require("nvim-tree").setup({
	on_attach = on_attach,
	hijack_netrw = true,
	disable_netrw = true,
	update_focused_file = {
		enable = true,
	},
	view = {
		width = 35,
		-- width = {},
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

	actions = {
		open_file = {
			quit_on_open = false,
		},
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
