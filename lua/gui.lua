---@diagnostic disable: inject-field, undefined-field
-- if nvim-qt, i can use fvim, neovide and nvy
FontSize = 14
FontFamily = "JetBrainsMono Nerd Font"

local utils = require("utils")
local apply_font = utils.apply_font
local map = utils.map

if utils.is_nvim_qt then
	apply_font({ font_family = "JetBrainsMono Nerd Font Mono" })
elseif utils.is_fvim then
	apply_font({ font_size = 14 })
else
	apply_font()
end

vim.opt.title = true

if utils.is_gui then
	local function increase_fontsize()
		utils.increase_font_size(1)
	end

	local function decrease_fontsize()
		utils.decrease_font_size(1)
	end

	map("n", "<C-=>", increase_fontsize)
	map("n", "<C-->", decrease_fontsize)
	map("n", "<leader>=", increase_fontsize)
	map("n", "<leader>-", decrease_fontsize)
	map("n", "<C-ScrollWheelUp>", increase_fontsize)
	map("n", "<C-ScrollWheelDown>", decrease_fontsize)
end

if not utils.is_goneovim then
	vim.opt.titlestring = vim.fn.fnamemodify(vim.fn.getcwd(), ":t")
end

if vim.g.neovide then
	-- vim.g.neovide_scroll_animation_length = 0
	-- vim.g.neovide_cursor_animate_in_insert_mode = false
	-- vim.g.neovide_cursor_trail_size = 0
	-- vim.g.neovide_scroll_animation_length = 0
	-- vim.g.neovide_cursor_antialiasing = false
	vim.g.neovide_fullscreen = false
	-- vim.g.neovide_input_use_logo = 0 -- enable use of the logo (cmd) key
	map("n", "<D-s>", ":w<CR>") -- Save
	map("v", "<D-c>", '"+y') -- Copy
	map("n", "<D-v>", '"+P') -- Paste normal mode
	map("v", "<D-v>", '"+P') -- Paste visual mode
	map("c", "<D-v>", "<C-R>+") -- Paste command mode
	map("i", "<D-v>", '<ESC>l"+Pli') -- Paste insert mode

	vim.g.neovide_scale_factor = 1.0

	local change_scale_factor = function(delta)
		vim.g.neovide_scale_factor = vim.g.neovide_scale_factor * delta
	end
	local diff = 1.1
	if vim.fn.has("macunix") then
		map("n", "<D-=>", function()
			change_scale_factor(diff)
		end)
		map("n", "<D-->", function()
			change_scale_factor(1 / diff)
		end)
	else
		map("n", "<A-=>", function()
			change_scale_factor(diff)
		end)
		map("n", "<A-->", function()
			change_scale_factor(1 / diff)
		end)
	end
end
