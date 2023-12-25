local api = vim.api

local startup = true

local function toggle_tree_focus()
	if vim.bo.filetype == "NvimTree" then
		if startup then
			startup = false
			vim.schedule(function()
				vim.opt_local.guicursor:append("n:Cursor/lCursor")
			end)
		else
			vim.opt_local.guicursor:append("n:Cursor/lCursor")
		end
	else
		vim.opt_local.guicursor:remove("n:Cursor/lCursor")
	end
end

-- api.nvim_create_autocmd({ "BufEnter" }, {
-- 	callback = toggle_tree_focus,
-- })
--
-- api.nvim_create_autocmd({ "Filetype" }, {
-- 	pattern = { "lazy", "DressingInput" },
-- 	callback = toggle_tree_focus,
-- })
