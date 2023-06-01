local cmd = vim.cmd
local exec = vim.api.nvim_exec
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
opt.spelllang = { "en_us", "ru" } -- Словари рус eng
opt.number = true -- Включаем нумерацию строк
opt.relativenumber = true -- Вкл. относительную нумерацию строк
opt.so = 10
opt.undofile = true -- Возможность отката назад
opt.mouse = "a"
g.mapleader = " "
cmd([[
filetype indent plugin on
syntax enable
]])

opt.shiftwidth = 2
opt.tabstop = 2
opt.smartindent = true -- autoindent new lines
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
	false
)

-- SET HTML AS HTML NOT DJANGO
cmd([[au BufNewFile,BufRead *.html set filetype=html]])

-- Lsp diagnostic auto
-- You will likely want to reduce updatetime which affects CursorHold
-- note: this setting is global and should be set only once
vim.o.updatetime = 1000

--Harpoon
cmd([[autocmd! CursorHold,CursorHoldI * lua vim.diagnostic.open_float(nil, {focus=false})]])
cmd("highlight! HarpoonInactive guibg=NONE guifg=#63698c")
cmd("highlight! HarpoonActive guibg=NONE guifg=white")
cmd("highlight! HarpoonNumberActive guibg=NONE guifg=#7aa2f7")
cmd("highlight! HarpoonNumberInactive guibg=NONE guifg=#7aa2f7")
cmd("highlight! TabLineFill guibg=NONE guifg=white")
