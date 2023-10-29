local function harpoon_files()
	local marks = require("harpoon").get_mark_config()["marks"]
	local active_index = require("harpoon.mark").get_index_of(vim.fn.bufname())

	local result = {}
	for index, value in pairs(marks) do
		local file = vim.fn.split(value["filename"], "/")
		file = file[#file]
		file = index == active_index and file .. "*" or file .. " "
		table.insert(result, " " .. file)
	end
	return table.concat(result)
end

return {
	{
		"nvim-lualine/lualine.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		opts = {
			sections = {
				lualine_a = { "mode" },
				lualine_b = { "branch", "diff", "diagnostics" },
				lualine_c = {
					{
						"filename",
						file_status = false, -- displays file status (readonly status, modified status)
						path = 0, -- 0 = just filename, 1 = relative path, 2 = absolute path
					},
				},
				lualine_x = { harpoon_files, "filetype" },
				lualine_y = { "progress" },

				-- lualine_z = { "location" },
				lualine_z = {},
			},
		},
	},
}
