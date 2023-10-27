vim.g.loaded = 1
vim.g.loaded_netrwPlugin = 1

local tree_utils = require("config.plugins.nvim-tree.utils")

local default_values = tree_utils.get_nvim_tree_values_from_cache()

local is_float = default_values.is_float
local quit_on_open = is_float or default_values.quit_on_open

local nmap = require("config.utils").nmap

local function on_attach(bufnr)
	local api = require("nvim-tree.api")
	local view_opts = require("nvim-tree.view").View

	api.events.subscribe(api.events.Event.FileCreated, function(file)
		if view_opts.float and view_opts.float.enable then
			api.tree.close()
		end
		vim.cmd("edit " .. file.fname)
	end)
	api.config.mappings.default_on_attach(bufnr)

	local function opts(desc)
		return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
	end

	nmap("L", api.node.open.edit, opts("Open"))
	nmap("l", api.node.open.no_window_picker, opts("Open: No Picker"))
	nmap("t", function()
		api.node.open.edit()
		api.tree.close()
	end, opts("Open With closing"))

	nmap("<ESC>", api.tree.close, opts("Close"))

	nmap("sv", api.node.open.vertical, opts("Open Split: Vertical"))
	nmap("sh", api.node.open.horizontal, opts("Open Split: Horizontal"))
	nmap("<M-v>", api.node.open.vertical, opts("Open Split: Vertical"))
	nmap("<M-h>", api.node.open.horizontal, opts("Open Split: Horizontal"))

	nmap("st", tree_utils.toggle_quit_on_open, opts("NvimTree Always Open Toggle State"))
	nmap("sf", tree_utils.toggle_floating, opts("NvimTree Toggle Floating"))
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
		-- preserve_window_proportions = true,
		cursorline = true,
		-- adaptive_size = quit_on_open,
		relativenumber = true,
		width = tree_utils.width,
		float = {
			enable = is_float,
			quit_on_focus_loss = false,
			open_win_config = function()
				local screen_w = vim.opt.columns:get()
				local screen_h = vim.opt.lines:get() - vim.opt.cmdheight:get()
				local window_w = screen_w * tree_utils.width_ratio
				local window_h = screen_h * tree_utils.height_ratio
				local window_w_int = math.floor(window_w)
				local window_h_int = math.floor(window_h)
				local center_x = (screen_w - window_w) / 2
				local center_y = ((vim.opt.lines:get() - window_h) / 2) - vim.opt.cmdheight:get()
				return {
					border = "rounded",
					relative = "editor",
					row = center_y,
					col = center_x,
					width = window_w_int,
					height = window_h_int,
				}
			end,
		},
	},
	actions = {
		open_file = {
			quit_on_open = quit_on_open,
		},
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

	if real_file and is_float then
		return
	end

	if real_file then
		require("nvim-tree.api").tree.toggle({ focus = false, find_file = true })
		return
	end

	require("nvim-tree.api").tree.open()
end

vim.api.nvim_create_autocmd({ "VimEnter" }, { callback = open_nvim_tree })

require("config.plugins.nvim-tree.cursorline")
