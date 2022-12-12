local cmd = vim.cmd -- execute Vim commands
local exec = vim.api.nvim_exec -- execute Vimscript
local g = vim.g -- global variables
local opt = vim.opt
-- Направление перевода с русского на английский
g.translate_source = 'ru'
g.translate_target = 'en'
opt.fillchars = 'eob: '


opt.signcolumn = "yes"
opt.ignorecase = true
opt.cmdheight = 1
opt.termguicolors = true
opt.spelllang = { 'en_us', 'ru' } -- Словари рус eng
opt.number = true -- Включаем нумерацию строк
opt.relativenumber = true -- Вкл. относительную нумерацию строк
opt.so = 7 -- Курсор всегда в центре экрана
opt.undofile = true -- Возможность отката назад
opt.mouse = 'a'
g.mapleader = " "
-- COLOR
-----------------------------------------------------------

-- Табы и отступы
-----------------------------------------------------------

cmd([[
filetype indent plugin on
syntax enable
]])

opt.shiftwidth = 2 -- shift 4 spaces when tab
opt.smartindent = true -- autoindent new lines
-- don't auto commenting new lines
cmd [[au BufEnter * set fo-=c fo-=r fo-=o]]
-- remove line lenght marker for selected filetypes
cmd [[autocmd FileType text,markdown,html,xhtml,javascript setlocal cc=0]]
-- 2 spaces for selected filetypes
cmd [[
autocmd FileType xml,html,xhtml,css,scss,javascript,lua,yaml,htmljinja setlocal shiftwidth=2 tabstop=2
]]
-- С этой строкой отлично форматирует html файл, который содержит jinja2
cmd [[ autocmd BufNewFile,BufRead *.html set filetype=htmldjango ]]
-----------------------------------------------------------
-- Полезные фишки
-----------------------------------------------------------
-- Запоминает где nvim последний раз редактировал файл
cmd [[
autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
map('n', '<Space>', '<PageDown> zz', default_opts)
]]
-- Подсвечивает на доли секунды скопированную часть текста
exec([[
augroup YankHighlight
autocmd!
autocmd TextYankPost * silent! lua vim.highlight.on_yank{higroup="IncSearch", timeout=100}
augroup end
]], false)

-- SET HTML AS HTML NOT DJANGO
cmd [[au BufNewFile,BufRead *.html set filetype=html]]
