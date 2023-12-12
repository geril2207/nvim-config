return {
	{
		"Theprimeagen/harpoon",
		dependencies = { "nvim-lua/plenary.nvim" },
		branch = "harpoon2",
		config = function()
			require("harpoon").setup()
		end,
	},
}
