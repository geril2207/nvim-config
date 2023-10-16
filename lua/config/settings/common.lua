local cmd = vim.cmd
local exec = vim.api.nvim_exec2
local g = vim.g
local opt = vim.opt
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
g.mapleader = " "
opt.tabstop = 2
opt.softtabstop = 2
opt.shiftwidth = 2
opt.expandtab = true
opt.smartindent = true
opt.timeoutlen = 500

-- opt.guicursor = ""
opt.showmode = false

-- don't auto commenting new lines
-- cmd([[au BufEnter * set fo-=c fo-=r fo-=o]])
-- Copy highlight
exec(
	[[
augroup YankHighlight
autocmd!
autocmd TextYankPost * silent! lua vim.highlight.on_yank{higroup="IncSearch", timeout=100}
augroup end
]],
	{ output = false }
)
cmd([[
filetype indent plugin on
syntax enable
]])

exec([[autocmd FileType * set formatoptions-=cro]], { output = false })
-- SET HTML AS HTML NOT DJANGO
cmd([[au BufNewFile,BufRead *.html set filetype=html]])

-- Lsp diagnostic auto
-- You will likely want to reduce updatetime which affects CursorHold
-- note: this setting is global and should be set only once
vim.o.updatetime = 250
