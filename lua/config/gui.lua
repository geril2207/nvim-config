---@diagnostic disable: inject-field, undefined-field
-- if nvim-qt, i can use fvim, neovide and nvy
FontSize = 14
FontFamily = "JetBrainsMono Nerd Font"

local utils = require("config.utils")
local apply_font = utils.apply_font
local map = utils.map
local imap = utils.imap
local nmap = utils.nmap
local vmap = utils.vmap

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

	nmap("<C-=>", increase_fontsize)
	nmap("<C-->", decrease_fontsize)
	nmap("n", "<leader>=", increase_fontsize)
	nmap("<leader>-", decrease_fontsize)
	nmap("<C-ScrollWheelUp>", increase_fontsize)
	nmap("<C-ScrollWheelDown>", decrease_fontsize)
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
	nmap("<D-s>", ":w<CR>") -- Save
	vmap("<D-c>", '"+y') -- Copy
	nmap("<D-v>", '"+P') -- Paste normal mode
	vmap("<D-v>", '"+P') -- Paste visual mode
	map("c", "<D-v>", "<C-R>+") -- Paste command mode
	imap("<D-v>", '<ESC>l"+Pli') -- Paste insert mode

	vim.g.neovide_scale_factor = 1.0

	local change_scale_factor = function(delta)
		vim.g.neovide_scale_factor = vim.g.neovide_scale_factor * delta
	end
	local diff = 1.1
	if vim.fn.has("macunix") then
		nmap("<D-=>", function()
			change_scale_factor(diff)
		end)
		nmap("<D-->", function()
			change_scale_factor(1 / diff)
		end)
	else
		nmap("<A-=>", function()
			change_scale_factor(diff)
		end)
		nmap("<A-->", function()
			change_scale_factor(1 / diff)
		end)
	end
end
