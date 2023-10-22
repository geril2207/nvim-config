local open_file_opts = require("nvim-tree.actions.node.open-file")
local cache_utils = require("utils.cache")

local cache = cache_utils.get_cache()

local M = {
	is_float = true,
	quit_on_open = true,
	height_ratio = 0.8, -- You can change this
	width_ratio = 0.5, -- You can change this too
}

if cache then
	if cache.is_float ~= nil then
		M.is_float = cache.is_float
	end

	if cache.quit_on_open ~= nil then
		M.quit_on_open = cache.quit_on_open
	end
end

function M.toggle_floating()
	local view = require("nvim-tree.view").View
	M.is_float = not M.is_float
	view.float.enable = M.is_float
	if M.is_float then
		open_file_opts.quit_on_open = true
	else
		open_file_opts.quit_on_open = open_file_opts.quit_on_open
	end

	cache_utils.set_cache({ quit_on_open = open_file_opts.quit_on_open, is_float = M.is_float })
end

function M.width()
	if M.is_float then
		return math.floor(vim.opt.columns:get() * M.width_ratio)
	else
		return 35
	end
end

function M.toggle_quit_on_open()
	M.quit_on_open = not M.quit_on_open
	open_file_opts.quit_on_open = M.quit_on_open

	cache_utils.set_cache_value("quit_on_open", M.quit_on_open)
end

return M
