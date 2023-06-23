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
-- opt.guicursor = ""
g.mapleader = " "
opt.tabstop = 2
opt.softtabstop = 2
opt.shiftwidth = 2
opt.expandtab = true
opt.smartindent = true

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
cmd([[
filetype indent plugin on
syntax enable
]])

exec([[autocmd FileType * set formatoptions-=cro]], false)
-- SET HTML AS HTML NOT DJANGO
cmd([[au BufNewFile,BufRead *.html set filetype=html]])

-- Lsp diagnostic auto
-- You will likely want to reduce updatetime which affects CursorHold
-- note: this setting is global and should be set only once
vim.o.updatetime = 250

--Harpoon
-- cmd([[autocmd! CursorHold lua vim.diagnostic.open_float(nil, {focus=false})]])

local function open_diagnostic()
	for _, winid in pairs(vim.api.nvim_tabpage_list_wins(0)) do
		if vim.api.nvim_win_get_config(winid).zindex then
			return
		end
	end
	vim.diagnostic.open_float(0, {
		scope = "cursor",
		focusable = false,
		close_events = {
			"CursorMoved",
			"CursorMovedI",
			"BufHidden",
			"InsertCharPre",
			"WinLeave",
		},
	})
end
-- Show diagnostics under the cursor when holding position
vim.api.nvim_create_augroup("lsp_diagnostics_hold", { clear = true })
vim.api.nvim_create_autocmd({ "CursorHold" }, {
	pattern = "*",
	callback = open_diagnostic,
	group = "lsp_diagnostics_hold",
})

opt.cursorline = vim.fn.has("gui_running") == 1 and vim.g.fvim_loaded ~= 1
vim.cmd([[colorscheme catppuccin]])

vim.cmd("hi! HarpoonInactive guibg=NONE guifg=#63698c")
vim.cmd("hi! HarpoonActive guibg=NONE guifg=white")
vim.cmd("hi! HarpoonNumberActive guibg=NONE guifg=#7aa2f7")
vim.cmd("hi! HarpoonNumberInactive guibg=NONE guifg=#7aa2f7")
vim.cmd("hi! TabLineFill guibg=NONE guifg=white")
