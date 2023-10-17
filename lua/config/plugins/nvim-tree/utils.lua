local M = {
	is_float = true,
	quit_on_open = true,
	height_ratio = 0.8, -- You can change this
	width_ratio = 0.5, -- You can change this too
}

local Path = require("plenary.path")
local open_file_opts = require("nvim-tree.actions.node.open-file")

local cache_file_path = string.format("%s/nvimtree.json", vim.fn.stdpath("data"))

local ok, cache = pcall(function()
	return vim.fn.json_decode(Path.new(cache_file_path):read())
end)

if ok then
	if cache.quit_on_open ~= nil and not M.is_float then
		M.quit_on_open = cache.quit_on_open
	end
end

local function write_cache(new_cache)
	Path.new(cache_file_path):write(vim.fn.json_encode(new_cache), "w")
end

function M.toggle_floating()
	local view = require("nvim-tree.view").View
	M.is_float = not M.is_float
	view.float.enable = M.is_float
	if M.is_float then
		open_file_opts.quit_on_open = true
	else
		open_file_opts.quit_on_open = M.quit_on_open
	end
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
	-- Path
	local cache = {
		quit_on_open = M.quit_on_open,
	}

	write_cache(cache)
end

return M
