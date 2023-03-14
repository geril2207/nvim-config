require 'nvim-treesitter.configs'.setup {
	ensure_installed = { "javascript", "lua", "tsx", "typescript", "scss", "css", "json", "dot", "html", "prisma" , "markdown"},
	sync_install = false,

	highlight = {
		enable = true,
		additional_vim_regex_highlighting = false,
	},


	autotag = {
		enable = true,
		filetypes = {
    'htmldjango',  'html', 'javascript', 'typescript', 'javascriptreact', 'typescriptreact', 'svelte', 'vue', 'tsx', 'jsx', 'rescript',
    'xml',
    'php',
    'markdown',
    'glimmer','handlebars','hbs'
	}
	},

	rainbow = {
		enable = true,
		extended_mode = false,
	},
	context_commentstring = {
		enable = true,
		enable_autocmd = false,
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
