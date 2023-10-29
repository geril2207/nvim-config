local g = vim.g
local opt = vim.opt
local api = vim.api

g.mapleader = " "
g.translate_source = "ru"
g.translate_target = "en"

opt.fillchars = "eob: "
opt.swapfile = false
opt.signcolumn = "yes"
opt.ignorecase = true
opt.cmdheight = 1
opt.termguicolors = true
opt.spelllang = { "en_us", "ru" }
opt.number = true
opt.relativenumber = true
opt.so = 10
opt.undofile = true
opt.mouse = "a"

opt.tabstop = 2
opt.softtabstop = 2
opt.shiftwidth = 2

opt.expandtab = true
opt.smartindent = true

opt.cursorlineopt = "number"
opt.clipboard = "unnamedplus"

opt.updatetime = 250
opt.timeoutlen = 500
opt.cursorline = true
opt.showmode = false
opt.laststatus = 3

api.nvim_create_autocmd("FileType", {
	pattern = "*",
	callback = function()
		opt.formatoptions = opt.formatoptions - "o" - "c"
	end,
})

api.nvim_create_autocmd("TextYankPost", {
	group = api.nvim_create_augroup("YankHighlight", { clear = true }),
	callback = function()
		vim.highlight.on_yank({ higroup = "IncSearch", timeout = 100 })
	end,
})
