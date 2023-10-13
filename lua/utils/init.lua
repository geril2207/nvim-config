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

M.transparent = vim.fn.has("gui_running") == 0

function M.apply_font(opts)
	opts = opts or {}
	if opts.font_family then
		FontFamily = opts.font_family
	end
	if opts.font_size then
		FontSize = opts.font_size
	end

	vim.o.guifont = FontFamily .. ":h" .. FontSize
end

function M.increase_font_size(value)
	M.apply_font({ font_size = FontSize + value })
end

function M.decrease_font_size(value)
	M.apply_font({ font_size = FontSize - value })
end

function M.map(mode, lhs, rhs, opts)
	local options = { noremap = true, silent = true }
	if opts then
		options = vim.tbl_extend("force", options, opts)
	end
	vim.keymap.set(mode, lhs, rhs, options)
end

function M.nmap(lhs, rhs, opts)
	M.map("n", lhs, rhs, opts)
end

function M.imap(lhs, rhs, opts)
	M.map("i", lhs, rhs, opts)
end

function M.vmap(lhs, rhs, opts)
	M.map("v", lhs, rhs, opts)
end

function M.nvmap(lhs, rhs, opts)
	M.map({ "n", "v" }, lhs, rhs, opts)
end

function M.map_double_leader(mode, lhs, rhs, opts)
	M.map(mode, "<leader><leader>" .. lhs, rhs, opts)
end

function M.nmap_double_leader(lhs, rhs, opts)
	M.map("n", "<leader><leader>" .. lhs, rhs, opts)
end

function M.setup_color_scheme(name, lazy)
	if lazy then
		require("themes." .. name)
	end
	vim.cmd("colorscheme " .. name)
	vim.opt.laststatus = 3

	vim.cmd("hi! HarpoonInactive guibg=NONE guifg=#63698c")
	vim.cmd("hi! HarpoonActive guibg=NONE guifg=white")
	vim.cmd("hi! HarpoonNumberActive guibg=NONE guifg=#7aa2f7")
	vim.cmd("hi! HarpoonNumberInactive guibg=NONE guifg=#7aa2f7")
	vim.cmd("hi! TabLineFill guibg=NONE guifg=white")
	vim.cmd("hi! NvimTreeNormal guibg='NONE'")
end

return M
