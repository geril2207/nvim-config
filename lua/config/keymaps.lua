local utils = require("utils")

local imap = utils.imap
local vmap = utils.vmap
local nmap = utils.nmap
local nvmap = utils.nvmap
local nmap_double_leader = utils.nmap_double_leader

nmap("<A-j>", ":m +1 <CR>")
nmap("<A-k>", ":m -2 <CR>")
vmap("<A-j>", ":m '>+1<CR>gv=gv")
vmap("<A-k>", ":m '<-2<CR>gv=gv")

nmap("<C-v>", '"+p')
vmap("<C-v>", '"+p')
imap("<C-v>", '<ESC>"+pa')
vmap("<leader>p", [["_dP]])
--Back jump
nmap("<leader>b", "<C-o>")
nmap("<leader>n", "<C-i>")
nmap("<C-n>", ":noh<CR>")
nmap("<Leader>e", ":NvimTreeFocus<CR>")
nmap("<Leader>ab", ":NvimTreeClose<CR>")
--map("n", "<Leader>e", ":Neotree focus<CR>")
imap("jk", "<ESC>")
imap("jj", "<ESC>")

nmap("K", "<ESC>")
vmap("K", "<ESC>")
nmap("<C-z>", ":undo<CR>")
nmap("<C-Z>", ":redo<CR>")
nmap("<C-s>", ":w<CR>")
vmap("Y", '"+y')
vmap("<C-c>", '"+y')
nmap("Y", '"+y')
nmap("M", "`")

local prev_amount = 15
local function get_amount_of_scrolling_lines()
	local firstline = vim.fn.line("w0")
	local lastline = vim.fn.line("w$")

	-- when last line of document <C-u> scrolls <10 lines
	prev_amount = math.max(math.floor((lastline - firstline) / 2), prev_amount)
	return prev_amount
end

local cmd = vim.cmd
local function execute_scroll(direction, history)
	history = history or false
	local visible_lines_to_scroll = get_amount_of_scrolling_lines()
	if history then
		cmd("normal! m'")
	end
	cmd("normal!" .. visible_lines_to_scroll .. direction)
	cmd("normal! zz")
end

nmap("<A-z>", function()
	vim.wo.wrap = not vim.wo.wrap
end)

nmap("<C-d>", function()
	execute_scroll("j")
end)

nmap("<C-u>", function()
	execute_scroll("k")
end)

nmap("<Tab>", ':lua require("harpoon.ui").nav_next()<CR>')
nmap("<S-Tab>", ':lua require("harpoon.ui").nav_prev()<CR>')

for i = 1, 9, 1 do
	if vim.fn.has("macunix") == 1 then
		nmap("<D-" .. i .. ">", ':lua require("harpoon.ui").nav_file(' .. i .. ")<CR>")
	else
		nmap("<A-" .. i .. ">", ':lua require("harpoon.ui").nav_file(' .. i .. ")<CR>")
	end
	nmap("<leader>" .. i, ':lua require("harpoon.ui").nav_file(' .. i .. ")<CR>")
end
nmap("<leader>ha", ":lua require('harpoon.mark').add_file()<CR>")
nmap("<leader>hl", ":lua require('harpoon.ui').toggle_quick_menu()<CR>")

--Telescope
nmap("<leader>snp", ":Telescope neoclip plus<CR>")
nmap("<leader>snu", ":Telescope neoclip unnamed<CR>")
nmap("<leader>sns", ":Telescope neoclip star<CR>")
nmap("<leader>ff", ":Telescope find_files<CR>")
nmap("<leader>p", ":Telescope find_files<CR>")
nmap("<leader>P", ":Telescope<CR>")
nmap("<leader>fp", ":Telescope resume<CR>")
nmap("<C-p>", ":Telescope find_files<CR>")
nmap("<leader>fz", ":Telescope live_grep<CR>")
nmap("<leader>fb", ":Telescope buffers<CR>")
nmap("<leader>fg", ":Telescope git_files<CR>")
nmap("<leader>u", ":Telescope undo<cr>")
nmap("<leader>fh", ":Telescope harpoon marks initial_mode=normal<CR>")
nmap("<leader>fm", ":Telescope marks<CR>")
nmap("<leader>fs", ":Telescope lsp_document_symbols <CR>")
nmap("<leader>fw", ":Telescope lsp_dynamic_workspace_symbols <CR>")
nmap("gf", ":Telescope lsp_references <CR>")
nmap("gt", ":Telescope lsp_type_definitions <CR>")
nmap("<leader>fd", ":Telescope diagnostics <CR>")

-- LSP Saga
nmap("<leader>sb", ":Lspsaga show_buf_diagnostics<CR>")
nmap("<leader>sw", ":Lspsaga show_workspace_diagnostics<CR>")
nmap("<leader>so", ":Lspsaga outline<CR>")
nmap("<leader>sh", ":Lspsaga hover_doc<CR>")
nmap("<leader>sf", ":Lspsaga lsp_finder<CR>")
nvmap("<leader>ca", ":Lspsaga code_action<CR>")
-- map("n", "<leader>r", ":Lspsaga rename<CR>")
-- map("n", "gd", ":Lspsaga peek_definition<CR>")
-- map("n", "gd", ":Lspsaga goto_definition<CR>")
-- map("n", "<leader>d", ":Lspsaga goto_definition<CR>")
nmap("<leader>cd", ":Lspsaga show_line_diagnostics<CR>")
nmap("<leader>cd", ":Lspsaga show_cursor_diagnostics<CR>")
-- map("n", "[e", ":Lspsaga diagnostic_jump_prev<CR>")
-- map("n", "]e", ":Lspsaga diagnostic_jump_next<CR>")
nmap("gp", ":Lspsaga peek_definition<CR>")
imap("<C-u>", "<C-g>u<C-u>", { silent = true })

-- Git
nvmap("<leader>gs", ":Gitsigns<CR>")
nvmap("<leader>gp", ":Gitsigns preview_hunk<CR>")
nvmap("<leader>gbs", ":Gitsigns stage_buffer<CR>")
nvmap("<leader>ghs", ":Gitsigns stage_hunk<CR>")
nvmap("<leader>ghu", ":Gitsigns undo_stage_hunk<CR>")
nvmap("<leader>ghn", ":Gitsigns next_hunk<CR>")
nvmap("<leader>ghN", ":Gitsigns prev_hunk<CR>")

-- Maps For Double Leader
-- Easy Motions
nmap_double_leader("w", ":HopWordAC<CR>")
nmap_double_leader("b", ":HopWordBC<CR>")
nmap_double_leader("f", ":HopChar1AC<CR>")
nmap_double_leader("F", ":HopChar1BC<CR>")
nmap_double_leader("W", ":HopWord<CR>")

-- nmap("<leader>aw", function()
-- 	local input = vim.fn.input("Width: ")
-- 	local ok, input_int = pcall(tonumber, input)
--
-- 	if ok and input_int then
-- 		vim.api.nvim_win_set_width(0, input_int)
-- 	end
-- end)
