local M = {}

M.is_fvim = vim.g.fvim_loaded
M.is_goneovim = vim.g.goneovim == 1
M.is_nvy = vim.g.nvy
M.is_neovide = vim.g.neovide
M.is_gui = vim.fn.has("gui_running") == 1
M.is_nvim_qt = vim.fn.has("gui_running") == 1
	and not vim.g.neovide
	and not vim.g.fvim_loaded
	and not vim.g.nvy
	and not M.is_goneovim

return M
