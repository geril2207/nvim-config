require 'nvim-treesitter.configs'.setup {
	ensure_installed = { "javascript", "lua", "tsx", "typescript", "scss", "css", "json", "dot", "html", "prisma" },
	sync_install = false,

	highlight = {
		enable = true,
		additional_vim_regex_highlighting = false,
	},

	rainbow = {
		enable = true,
		extended_mode = false,
	}
}
--[[
    -- rainbowcol1 = { fg = "#FFD700"},
    -- rainbowcol2 = { fg = "#da70d6"},
    -- rainbowcol3 = { fg = "#87CEFA"},
    -- rainbowcol4 = { fg = "#FFD700"},
    -- rainbowcol5 = { fg = "#da70d6"},
    -- rainbowcol6 = { fg = "#87CEFA"},
    -- rainbowcol7 = { fg = "#FFD700"},
]]
