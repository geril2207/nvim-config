local function harpoon_files()
	local marks = require("harpoon"):list():display()
	local cur_buf = vim.fn.bufname()

	local result = {}
	for index, file in pairs(marks) do
		local filename_tail = vim.fn.split(file, "/")
		filename_tail = filename_tail[#filename_tail]
		local displayed = file == cur_buf and filename_tail .. "*" or filename_tail .. " "
		table.insert(result, " " .. displayed)
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
