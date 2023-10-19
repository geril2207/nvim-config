local function harpoon_files()
	local marks = require("harpoon").get_mark_config()["marks"]
	local current_file = vim.fn.split(vim.api.nvim_buf_get_name(0), "/")
	current_file = current_file[#current_file]
	local ret = {}
	for _, value in pairs(marks) do
		local file = vim.fn.split(value["filename"], "/")
		file = file[#file]
		file = file == current_file and file .. "*" or file .. " "
		table.insert(ret, " " .. file)
	end
	return table.concat(ret)
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
