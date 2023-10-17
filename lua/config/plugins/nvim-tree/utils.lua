local M = {
	quit_on_open = false,
	is_float = true,
	height_ratio = 0.8, -- You can change this
	width_ratio = 0.5, -- You can change this too
}

local Path = require("plenary.path")

local cache_file_path = string.format("%s/nvimtree.json", vim.fn.stdpath("data"))

local ok, cache = pcall(function()
	return vim.fn.json_decode(Path.new(cache_file_path):read())
end)

if ok then
	if cache.quit_on_open ~= nil then
		M.quit_on_open = cache.quit_on_open
	end
end

function M.write_cache(new_cache)
	Path.new(cache_file_path):write(vim.fn.json_encode(new_cache), "w")
end

function M.toggle_floating()
	local view = require("nvim-tree.view").View
	M.is_float = not M.is_float
	view.float.enable = M.is_float
end

function M.width()
	if M.is_float then
		return math.floor(vim.opt.columns:get() * M.width_ratio)
	else
		return 35
	end
end

return M
