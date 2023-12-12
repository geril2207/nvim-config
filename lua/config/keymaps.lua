local map_utils = require("config.utils.map")
local map = map_utils.map
local map_tbl = map_utils.map_tbl
local mcmd = map_utils.cmd
local double_leader = map_utils.double_leader

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

map_tbl({
	i = {
		["jk"] = "<ESC>",
		["jj"] = "<ESC>",
		["<C-v>"] = '<ESC>"+pa',
	},

	n = {
		["<A-j>"] = ":m +1 <CR>",
		["<A-k>"] = ":m -2 <CR>",
		["<C-v>"] = '"+p',
		["<leader>b"] = "<C-o>",
		["<leader>n"] = "<C-i>",
		["<C-n>"] = mcmd("noh"),
		["<leader>e"] = mcmd("NvimTreeFocus"),
		["<leader>ab"] = mcmd("NvimTreeClose"),
		["K"] = "<ESC>",
		["<C-z>"] = mcmd("undo"),
		["<C-Z>"] = mcmd("redo"),
		["<C-s>"] = mcmd("silent! w"),
		["Y"] = '"+y',
		["M"] = "`",

		["<Tab>"] = mcmd("tabnext"),
		["<S-Tab>"] = mcmd("tabprev"),

		["<leader>snp"] = mcmd("Telescope neoclip plus"),
		["<leader>sn"] = mcmd("Telescope neoclip"),
		["<leader>snu"] = mcmd("Telescope neoclip unnamed"),
		["<leader>sns"] = mcmd("Telescope neoclip star"),
		["<leader>ff"] = mcmd("Telescope find_files"),
		["<leader>p"] = mcmd("Telescope find_files"),
		["<leader>P"] = mcmd("Telescope"),
		["<leader>fp"] = mcmd("Telescope resume"),
		["<C-p>"] = mcmd("Telescope find_files"),
		["<leader>fz"] = mcmd("Telescope live_grep"),
		["<leader>fl"] = mcmd("Telescope grep_string"),
		["<leader>fb"] = mcmd("Telescope buffers"),
		["<leader>fg"] = mcmd("Telescope git_files"),
		["<leader>u"] = mcmd("Telescope undo"),
		["<leader>fh"] = mcmd("Telescope harpoon marks initial_mode=normal"),
		["<leader>fm"] = mcmd("Telescope marks"),
		["<leader>fs"] = mcmd("Telescope lsp_document_symbols"),
		["<leader>fw"] = mcmd("Telescope lsp_dynamic_workspace_symbols"),
		["gf"] = mcmd("Telescope lsp_references"),
		["gt"] = mcmd("Telescope lsp_type_definitions"),
		["<leader>fd"] = mcmd("Telescope diagnostics "),
		["<leader>sb"] = mcmd("Lspsaga show_buf_diagnostics"),
		["<leader>sw"] = mcmd("Lspsaga show_workspace_diagnostics"),
		["<leader>so"] = mcmd("Lspsaga outline"),
		["<leader>sh"] = mcmd("Lspsaga hover_doc"),
		["<leader>sf"] = mcmd("Lspsaga lsp_finder"),
		["<leader>ha"] = mcmd("lua require('harpoon.mark').add_file()"),
		["<leader>hl"] = mcmd("lua require('harpoon.ui').toggle_quick_menu()"),
		["<leader>cd"] = mcmd("Lspsaga show_line_diagnostics"),
		--?
		-- ["<leader>cd"] = ":Lspsaga show_cursor_diagnostics<CR>",
		["gp"] = mcmd("Lspsaga peek_definition"),

		["<A-z>"] = function()
			vim.wo.wrap = not vim.wo.wrap
		end,

		[double_leader("w")] = mcmd("HopWordAC"),
		[double_leader("b")] = mcmd("HopWordBC"),
		[double_leader("f")] = mcmd("HopChar1AC"),
		[double_leader("F")] = mcmd("HopChar1BC"),
		[double_leader("W")] = mcmd("HopWord"),
	},

	nv = {
		["<leader>ca"] = mcmd("Lspsaga code_action"),
		["<leader>gs"] = mcmd("Gitsigns"),
		["<leader>gp"] = mcmd("Gitsigns preview_hunk"),
		["<leader>gbs"] = mcmd("Gitsigns stage_buffer"),
		["<leader>ghs"] = mcmd("Gitsigns stage_hunk"),
		["<leader>ghu"] = mcmd("Gitsigns undo_stage_hunk"),
		["]g"] = mcmd("Gitsigns next_hunk"),
		["[g"] = mcmd("Gitsigns prev_hunk"),

		["<C-d>"] = function()
			execute_scroll("j")
		end,

		["<C-u>"] = function()
			execute_scroll("k")
		end,
	},

	v = {
		["<A-j>"] = ":m '>+1<CR>gv=gv",
		["<A-k>"] = ":m '<-2<CR>gv=gv",
		["<C-v>"] = '"+p',
		["<leader>p"] = [["_dP]],
		["Y"] = '"+y',
		["y"] = "ygv<ESC>",
		["<C-c>"] = '"+y',
		["K"] = "<ESC>",
	},

	t = {
		["<ESC>"] = "<C-\\><C-n>",
	},
})

---@param index integer
local function go_to_tab(index)
	local list_tabs = vim.api.nvim_list_tabpages()

	for i = 1, #list_tabs, 1 do
		if index == i then
			pcall(function()
				vim.api.nvim_set_current_tabpage(list_tabs[index])
			end)
		end
	end
end

for i = 1, 9, 1 do
	if vim.fn.has("macunix") == 1 then
		map("n", string.format("<D-%s>", i), string.format(':lua require("harpoon.ui").nav_file(%s)<CR>', i))
	else
		map("n", string.format("<A-%s>", i), string.format(':lua require("harpoon.ui").nav_file(%s)<CR>', i))
	end
	-- map("n", "<leader>" .. i, ':lua require("bufferline").go_to(' .. i .. ")<CR>")
	map("n", string.format("<leader>%s", i), function()
		go_to_tab(i)
	end)
end
