-- if nvim-qt, i can use fvim, neovide and nvy
local utils = require("utils")
if utils.is_nvim_qt then
	vim.o.guifont = "JetBrainsMono Nerd Font Mono:h14"
elseif utils.is_fvim then
	vim.o.guifont = "JetBrainsMono Nerd Font:h19"
else
	vim.o.guifont = "JetBrainsMono Nerd Font:h14"
end
vim.opt.title = true

if not require("utils").is_goneovim then
	vim.opt.titlestring = vim.fn.fnamemodify(vim.loop.cwd(), ":t")
end

if vim.g.neovide then
	vim.g.neovide_cursor_animate_in_insert_mode = false
	vim.g.neovide_cursor_antialiasing = true
	vim.g.neovide_fullscreen = false
	-- vim.g.neovide_input_use_logo = 0 -- enable use of the logo (cmd) key
	vim.keymap.set("n", "<D-s>", ":w<CR>") -- Save
	vim.keymap.set("v", "<D-c>", '"+y') -- Copy
	vim.keymap.set("n", "<D-v>", '"+P') -- Paste normal mode
	vim.keymap.set("v", "<D-v>", '"+P') -- Paste visual mode
	vim.keymap.set("c", "<D-v>", "<C-R>+") -- Paste command mode
	vim.keymap.set("i", "<D-v>", '<ESC>l"+Pli') -- Paste insert mode

	vim.g.neovide_scale_factor = 1.0

	local change_scale_factor = function(delta)
		vim.g.neovide_scale_factor = vim.g.neovide_scale_factor * delta
	end
	local diff = 1.1
	if vim.fn.has("macunix") then
		vim.keymap.set("n", "<D-=>", function()
			change_scale_factor(diff)
		end)
		vim.keymap.set("n", "<D-->", function()
			change_scale_factor(1 / diff)
		end)
	else
		vim.keymap.set("n", "<A-=>", function()
			change_scale_factor(diff)
		end)
		vim.keymap.set("n", "<A-->", function()
			change_scale_factor(1 / diff)
		end)
	end
end
