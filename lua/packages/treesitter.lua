require'nvim-treesitter.configs'.setup {
    ensure_installed = { "javascript", "lua", "tsx","typescript", "scss", "css", "json","dot","html", "prisma"},
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
