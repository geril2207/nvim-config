return {
	{
		"phaazon/hop.nvim",
		branch = "v2", -- optional but strongly recommended
		commit = "caaccee",

		config = function()
			require("hop").setup()
		end,
	},
}
