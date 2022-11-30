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

--Back jump
map("n", "<leader>b", "<C-o>", {})
map("n", "<C-n>", ":noh<CR>", {})
map("n", "<Leader>e", ":NvimTreeFocus<CR>", {})
--map("n", "<Leader>e", ":Neotree focus<CR>", {})
map("i", "jk", "<ESC>", {})
map("i", "jj", "<ESC>", {})

map("n", "K", "<ESC>", {})
map("n", "<C-z>", ":undo<CR>", {})
map("n", "<C-Z>", ":redo<CR>", {})
map("n", "<C-s>", ":w<CR>", {})
map("n", "<C-w>", ":Bdelete<CR>", {})
map("v", 'Y', '"+y', {})
map("v", '<C-c>', '"+y', {})
map("n", 'Y', '"+y', {})
map("n", "<leader>qq", ":q!<CR>:q!<CR>:q!<CR>:q!<CR>", {})
-- BufferLine
map('n', '<S-Tab>', ':BufferLineCyclePrev<CR>', {})
-- map('n', 'J', ':BufferLineCyclePrev<CR>', {})

map('n', '<Tab>', ':BufferLineCycleNext<CR>', {})
-- map('n', 'K', ':BufferLineCycleNext<CR>', {})
map('n', '<A-1>', ':BufferLineGoToBuffer 1<CR>', {})
map('n', '<A-2>', ':BufferLineGoToBuffer 2<CR>', {})
map('n', '<A-3>', ':BufferLineGoToBuffer 3<CR>', {})
map('n', '<A-4>', ':BufferLineGoToBuffer 4<CR>', {})
map('n', '<A-5>', ':BufferLineGoToBuffer 5<CR>', {})
map('n', '<A-6>', ':BufferLineGoToBuffer 6<CR>', {})
map('n', '<A-7>', ':BufferLineGoToBuffer 7<CR>', {})
map('n', '<A-8>', ':BufferLineGoToBuffer 8<CR>', {})
map('n', '<A-9>', ':BufferLineGoToBuffer 9<CR>', {})
map("n", "<leader>kw", ":BufferCloseAllButCurrentOrPinned<CR>", {})

--Telescope
map('n', '<leader>ff', ":Telescope find_files<CR>", {})
map('n', '<leader>p', ":Telescope find_files<CR>", {})
map('n', '<C-p>', ":Telescope find_files<CR>", {})
map('n', '<leader>fz', ":Telescope live_grep<CR>", {})
map('n', '<leader>fb', ":Telescope buffers<CR>", {})
map('n', '<leader>fh', ":Telescope help_tags<CR>", {})

-- LSP Saga
map("n", "gh", "<cmd>Lspsaga hover_doc<CR>", {})
map("n", "gf", "<cmd>Lspsaga lsp_finder<CR>", {})
map("n", "<leader>ca", "<cmd>Lspsaga code_action<CR>", {})
map("v", "<leader>ca", "<cmd>Lspsaga code_action<CR>", {})
map("n", "<leader>r", "<cmd>Lspsaga rename<CR>", {})
-- map("n", "gd", "<cmd>Lspsaga peek_definition<CR>", {})
-- map("n", "<leader>d", "<cmd>Lspsaga peek_definition<CR>", {})
map("n", "<leader>cd", "<cmd>Lspsaga show_line_diagnostics<CR>", {})
map("n", "<leader>cd", "<cmd>Lspsaga show_cursor_diagnostics<CR>", {})
map("n", "[e", "<cmd>Lspsaga diagnostic_jump_prev<CR>", {})
map("n", "]e", "<cmd>Lspsaga diagnostic_jump_next<CR>", {})
map("n", "<A-F>", ":Prettier<CR>", {})

-- Maps For Double Leader

-- Easy Motions
mapDoubleLeader("n", "w", ":HopWordAC<CR>", {})
mapDoubleLeader("n", "b", ":HopWordBC<CR>", {})
mapDoubleLeader("n", "f", ":HopChar1AC<CR>", {})
mapDoubleLeader("n", "F", ":HopChar1BC<CR>", {})
mapDoubleLeader("n", "W", ":HopWord<CR>", {})
