local utils = require("utils")

local map = utils.map
local map_double_leader = utils.map_double_leader

map("n", "<A-j>", ":m +1 <CR>")
map("n", "<A-k>", ":m -2 <CR>")
map("v", "<A-j>", ":m '>+1<CR>gv=gv")
map("v", "<A-k>", ":m '<-2<CR>gv=gv")

map("n", "<C-v>", '"+p')
map("v", "<C-v>", '"+p')
map("i", "<C-v>", '<ESC>"+pa')
map("v", "<leader>p", [["_dP]])
--Back jump
map("n", "<leader>b", "<C-o>")
map("n", "<leader>n", "<C-i>")
map("n", "<C-n>", ":noh<CR>")
map("n", "<Leader>e", ":NvimTreeFocus<CR>")
map("n", "<Leader>ab", ":NvimTreeClose<CR>")
--map("n", "<Leader>e", ":Neotree focus<CR>")
map("i", "jk", "<ESC>")
map("i", "jj", "<ESC>")

map("n", "K", "<ESC>")
map("v", "K", "<ESC>")
map("n", "<C-z>", ":undo<CR>")
map("n", "<C-Z>", ":redo<CR>")
map("n", "<C-s>", ":w<CR>")
map("v", "Y", '"+y')
map("v", "<C-c>", '"+y')
map("n", "Y", '"+y')
map("n", "M", "`")

local prev_amount = 15
local function get_amount_of_scrolling_lines()
	local firstline = vim.fn.line("w0")
	local lastline = vim.fn.line("w$")

	-- when last line of document <C-u> scrolls <10 lines
	prev_amount = math.max(math.floor((lastline - firstline) / 2), prev_amount)
	return prev_amount
end

local function execute_scroll(direction, history)
	history = history or false
	local visible_lines_to_scroll = get_amount_of_scrolling_lines()
	if history then
		vim.api.nvim_command("normal! m'")
	end
	vim.api.nvim_command("normal!" .. visible_lines_to_scroll .. direction)
	vim.api.nvim_command("normal! zz")
end

map("n", "<A-z>", function()
	vim.wo.wrap = not vim.wo.wrap
end)

map("n", "<C-d>", function()
	execute_scroll("j")
end)

map("n", "<C-u>", function()
	execute_scroll("k")
end)

map("n", "<Tab>", ':lua require("harpoon.ui").nav_next()<CR>')
map("n", "<S-Tab>", ':lua require("harpoon.ui").nav_prev()<CR>')

for i = 1, 9, 1 do
	if vim.fn.has("macunix") == 1 then
		map("n", "<D-" .. i .. ">", ':lua require("harpoon.ui").nav_file(' .. i .. ")<CR>")
	else
		map("n", "<A-" .. i .. ">", ':lua require("harpoon.ui").nav_file(' .. i .. ")<CR>")
	end
	map("n", "<leader>" .. i, ':lua require("harpoon.ui").nav_file(' .. i .. ")<CR>")
end
map("n", "<leader>ha", ":lua require('harpoon.mark').add_file()<CR>")
map("n", "<leader>hl", ":lua require('harpoon.ui').toggle_quick_menu()<CR>")

--Telescope
map("n", "<leader>snp", ":Telescope neoclip plus<CR>")
map("n", "<leader>snu", ":Telescope neoclip unnamed<CR>")
map("n", "<leader>sns", ":Telescope neoclip star<CR>")
map("n", "<leader>ff", ":Telescope find_files<CR>")
map("n", "<leader>p", ":Telescope find_files<CR>")
map("n", "<leader>P", ":Telescope<CR>")
map("n", "<leader>fp", ":Telescope resume<CR>")
map("n", "<C-p>", ":Telescope find_files<CR>")
map("n", "<leader>fz", ":Telescope live_grep<CR>")
map("n", "<leader>fb", ":Telescope buffers<CR>")
map("n", "<leader>fg", ":Telescope git_files<CR>")
map("n", "<leader>u", "<cmd>Telescope undo<cr>")
map("n", "<leader>fh", ":Telescope harpoon marks initial_mode=normal<CR>")
map("n", "<leader>fm", ":Telescope marks<CR>")
map("n", "gf", ":Telescope lsp_references <CR>")
map("n", "<leader>fs", ":Telescope lsp_document_symbols <CR>")
map("n", "<leader>fw", ":Telescope lsp_dynamic_workspace_symbols <CR>")
map("n", "<leader>fd", ":Telescope diagnostics <CR>")

-- LSP Saga
map("n", "<leader>sb", "<cmd>Lspsaga show_buf_diagnostics<CR>")
map("n", "<leader>sw", "<cmd>Lspsaga show_workspace_diagnostics<CR>")
map("n", "<leader>so", "<cmd>Lspsaga outline<CR>")
map("n", "<leader>sh", "<cmd>Lspsaga hover_doc<CR>")
map("n", "<leader>sf", "<cmd>Lspsaga lsp_finder<CR>")
map({ "n", "v" }, "<leader>ca", "<cmd>Lspsaga code_action<CR>")
-- map("n", "<leader>r", "<cmd>Lspsaga rename<CR>")
-- map("n", "gd", "<cmd>Lspsaga peek_definition<CR>")
-- map("n", "gd", "<cmd>Lspsaga goto_definition<CR>")
-- map("n", "<leader>d", "<cmd>Lspsaga goto_definition<CR>")
map("n", "<leader>cd", "<cmd>Lspsaga show_line_diagnostics<CR>")
map("n", "<leader>cd", "<cmd>Lspsaga show_cursor_diagnostics<CR>")
-- map("n", "[e", "<cmd>Lspsaga diagnostic_jump_prev<CR>")
-- map("n", "]e", "<cmd>Lspsaga diagnostic_jump_next<CR>")
map("n", "gp", "<cmd>Lspsaga peek_definition<CR>")
map("i", "<C-u>", "<C-g>u<C-u>", { silent = true })

-- Git
map({ "n", "v" }, "<leader>gs", ":Gitsigns<CR>")
map({ "n", "v" }, "<leader>gbs", ":Gitsigns stage_buffer<CR>")
map({ "n", "v" }, "<leader>ghs", ":Gitsigns stage_hunk<CR>")
map({ "n", "v" }, "<leader>ghu", ":Gitsigns undo_stage_hunk<CR>")
map({ "n", "v" }, "<leader>ghn", ":Gitsigns next_hunk<CR>")
map({ "n", "v" }, "<leader>ghN", ":Gitsigns prev_hunk<CR>")

-- Maps For Double Leader
-- Easy Motions
map_double_leader("n", "w", ":HopWordAC<CR>")
map_double_leader("n", "b", ":HopWordBC<CR>")
map_double_leader("n", "f", ":HopChar1AC<CR>")
map_double_leader("n", "F", ":HopChar1BC<CR>")
map_double_leader("n", "W", ":HopWord<CR>")
