vim.o.guifont = "JetBrainsMono Nerd Font:h13.6"
vim.opt.title = true
vim.opt.titlestring = vim.loop.cwd()

if vim.g.neovide then
	vim.g.neovide_cursor_animate_in_insert_mode = false
	vim.g.neovide_cursor_antialiasing = true
	vim.g.neovide_fullscreen = false
	-- vim.g.neovide_input_use_logo = 1 -- enable use of the logo (cmd) key
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
	vim.keymap.set("n", "<A-=>", function()
		change_scale_factor(diff)
	end)
	vim.keymap.set("n", "<A-->", function()
		change_scale_factor(1 / diff)
	end)
end

if vim.g.fvim_loaded then
	vim.o.guifont = "JetBrainsMono Nerd Font:h18"
end
