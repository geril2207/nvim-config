local utils = require("utils.map")
return {
	{
		"ibhagwan/fzf-lua",
		-- optional for icon support
		dependencies = { "nvim-tree/nvim-web-devicons" },
		config = function()
			-- calling `setup` is optional for customization
			require("fzf-lua").setup({

				winopts = {
					title = "",
					height = 0.7,
					width = 0.7,
					preview = {
						scrollbar = false,
						layout = "vertical",
						vertical = "down:45%",
					},
				},
				files = {
					cwd_prompt = false,
				},
			})
		end,
	},
}
