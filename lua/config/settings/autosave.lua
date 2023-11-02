local api = vim.api

local group = api.nvim_create_augroup("AutoSave", { clear = true })

local filetypes_to_ignore = { "harpoon" }

api.nvim_create_autocmd({ "BufLeave", "TextChanged", "InsertLeave" }, {
	group = group,
	desc = "AutoSave",
	callback = function(opts)
		local modifiable = vim.bo.modifiable
		local readonly = vim.bo.readonly
		local filetype = vim.bo.filetype
		local file = opts.file

		local is_modified = api.nvim_get_option_value("modified", { buf = 0 })

		if not is_modified then
			return
		end

		if modifiable and not readonly and file ~= "" then
			for _, value in ipairs(filetypes_to_ignore) do
				if value == filetype then
					return
				end
			end

			vim.cmd("silent! write")
		end
	end,
})
