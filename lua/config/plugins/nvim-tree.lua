vim.g.loaded = 1
vim.g.loaded_netrwPlugin = 1

local Path = require("plenary.path")

local cache_file_path = string.format("%s/nvimtree.json", vim.fn.stdpath("data"))
local quit_on_open = false

local ok, cache = pcall(function()
	return vim.fn.json_decode(Path.new(cache_file_path):read())
end)

if ok then
	if cache.quit_on_open ~= nil then
		quit_on_open = cache.quit_on_open
	end
end

local function toggle_quit_on_open()
	local open_file_opts = require("nvim-tree.actions.node.open-file")
	quit_on_open = not quit_on_open
	open_file_opts.quit_on_open = quit_on_open
	-- Path
	local cache = {
		quit_on_open = quit_on_open,
	}
	Path.new(cache_file_path):write(vim.fn.json_encode(cache), "w")
end

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

	vim.keymap.set("n", "st", toggle_quit_on_open, opts("NvimTree Always Open Toggle State"))
end

local height_ratio = 0.8 -- You can change this
local width_ratio = 0.5 -- You can change this too
local is_float = false

-- empty setup using defaults
require("nvim-tree").setup({
	on_attach = on_attach,
	hijack_netrw = true,
	disable_netrw = true,
	update_focused_file = {
		enable = true,
	},
	view = {
		preserve_window_proportions = true,
		relativenumber = true,
		width = function()
			if is_float then
				return math.floor(vim.opt.columns:get() * width_ratio)
			else
				return 35
			end
		end,
		float = {
			enable = is_float,
			open_win_config = function()
				local screen_w = vim.opt.columns:get()
				local screen_h = vim.opt.lines:get() - vim.opt.cmdheight:get()
				local window_w = screen_w * width_ratio
				local window_h = screen_h * height_ratio
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
			quit_on_open = quit_on_open,
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
