local api = vim.api

local function toggle_tree_focus()
	if vim.bo.filetype == "NvimTree" then
		vim.opt_local.guicursor:append("n:Cursor/lCursor")
	else
		vim.opt_local.guicursor:remove("n:Cursor/lCursor")
	end
end

api.nvim_create_autocmd({ "BufEnter" }, {
	callback = toggle_tree_focus,
})

api.nvim_create_autocmd({ "Filetype" }, {
	pattern = "lazy",
	callback = toggle_tree_focus,
})
