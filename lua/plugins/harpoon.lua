return {
	{
		"geril2207/harpoon",
		dependencies = { "nvim-lua/plenary.nvim" },
		config = function()
			require("harpoon").setup({
				tabline = true,
				save_on_toggle = false,
				global_settings = {
					tabline = true,
				},
			})
		end,
	},
}
