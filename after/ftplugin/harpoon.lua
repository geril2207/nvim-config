vim.wo.winbar = nil

-- vertical split alt+v
vim.keymap.set("n", "<M-v>", function()
	local cur_win = vim.api.nvim_get_current_win()
	local curline = vim.api.nvim_get_current_line()
	vim.api.nvim_win_close(cur_win, true)
	vim.cmd("vsp " .. curline)
end, { buffer = true, noremap = true, silent = true })

-- horizontal split alt+h
vim.keymap.set("n", "<M-h>", function()
	local cur_win = vim.api.nvim_get_current_win()
	local curline = vim.api.nvim_get_current_line()
	vim.api.nvim_win_close(cur_win, true)
	vim.cmd("sp " .. curline)
end, { buffer = true, noremap = true, silent = true })
