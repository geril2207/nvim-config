local function map(mode, lhs, rhs, opts)
	local options = { noremap = true, silent = true }
	if opts then
		options = vim.tbl_extend("force", options, opts)
	end
	vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

local function mapDoubleLeader(mode, lhs, rhs, opts)
	map(mode, "<leader><leader>" .. lhs, rhs, opts)
end

map("n", "<A-j>", ":m +1 <CR>")
map("n", "<A-k>", ":m -2 <CR>")

map("n", "<C-v>", '"+p')
map("v", "<C-v>", '"+p')
map("i", "<C-v>", '<ESC>"+pa')
--Back jump
map("n", "<leader>b", "<C-o>")
map("n", "<C-n>", ":noh<CR>")
map("n", "<Leader>e", ":NvimTreeFocus<CR>")
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
map("n", "<leader>qq", ":q!<CR>:q!<CR>:q!<CR>:q!<CR>")
map("n", "M", "`")

local function get_amount_of_scrolling_lines()
	local firstline = vim.fn.line("w0")
	local lastline = vim.fn.line("w$")
	local min_amount = 18

	return math.max(math.floor((lastline - firstline) / 2), min_amount)
end

local function execute_scroll(direction)
	local visible_lines_to_scroll = get_amount_of_scrolling_lines()
	vim.api.nvim_command("normal!" .. visible_lines_to_scroll .. direction)
	vim.api.nvim_command("normal! zz")
end

vim.keymap.set("n", "<C-d>", function()
	execute_scroll("j")
end)
vim.keymap.set("n", "<C-u>", function()
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
-- map("n", "<leader>ff", ":Telescope find_files<CR>")
map("n", "<leader>p", ":Telescope find_files<CR>")
map("n", "<leader>P", ":Telescope<CR>")
map("n", "<C-p>", ":Telescope find_files<CR>")
map("n", "<leader>fz", ":Telescope live_grep<CR>")
map("n", "<leader>fb", ":Telescope buffers<CR>")
map("n", "<leader>fg", ":Telescope git_files<CR>")
map("n", "<leader>u", "<cmd>Telescope undo<cr>")
map("n", "<leader>fm", ":Telescope marks<CR>")
map("n", "<leader>fh", ":Telescope harpoon marks initial_mode=normal<CR>")
map("n", "<leader>ff", ":Telescope lsp_references <CR>")
map("n", "<leader>fs", ":Telescope lsp_document_symbols <CR>")

-- LSP Saga
map("n", "<leader>sb", "<cmd>Lspsaga show_buf_diagnostics<CR>")
map("n", "<leader>sw", "<cmd>Lspsaga show_workspace_diagnostics<CR>")
map("n", "<leader>so", "<cmd>Lspsaga outline<CR>")
map("n", "gh", "<cmd>Lspsaga hover_doc<CR>")
map("n", "gf", "<cmd>Lspsaga lsp_finder<CR>")
map("n", "<leader>ca", "<cmd>Lspsaga code_action<CR>")
map("v", "<leader>ca", "<cmd>Lspsaga code_action<CR>")
map("n", "<leader>r", "<cmd>Lspsaga rename<CR>")
-- map("n", "gd", "<cmd>Lspsaga peek_definition<CR>")
map("n", "gd", "<cmd>Lspsaga goto_definition<CR>")
map("n", "<leader>d", "<cmd>Lspsaga goto_definition<CR>")
map("n", "<leader>cd", "<cmd>Lspsaga show_line_diagnostics<CR>")
map("n", "<leader>cd", "<cmd>Lspsaga show_cursor_diagnostics<CR>")
map("n", "[e", "<cmd>Lspsaga diagnostic_jump_prev<CR>")
map("n", "]e", "<cmd>Lspsaga diagnostic_jump_next<CR>")
map("n", "gt", "<cmd>Lspsaga goto_type_definition<CR>")
map("n", "gp", "<cmd>Lspsaga peek_definition<CR>")
map("i", "<C-u>", "<C-g>u<C-u>", { silent = true })

-- Maps For Double Leader
-- Easy Motions
mapDoubleLeader("n", "w", ":HopWordAC<CR>")
mapDoubleLeader("n", "b", ":HopWordBC<CR>")
mapDoubleLeader("n", "f", ":HopChar1AC<CR>")
mapDoubleLeader("n", "F", ":HopChar1BC<CR>")
mapDoubleLeader("n", "W", ":HopWord<CR>")
mapDoubleLeader("n", "tg", "<cmd>:colorscheme gruvbox<CR>")
mapDoubleLeader("n", "tt", "<cmd>:colorscheme tokyonight<CR>")
mapDoubleLeader("n", "to", "<cmd>:colorscheme onedark<CR>")
mapDoubleLeader("n", "tc", "<cmd>:colorscheme catppuccin<CR>")
