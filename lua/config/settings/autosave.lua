local group = vim.api.nvim_create_augroup("AutoSave", { clear = true })

local filetypes_to_ignore = { "harpoon" }

vim.api.nvim_create_autocmd({ "BufLeave", "TextChanged", "InsertLeave" }, {
	group = group,
	desc = "AutoSave",
	callback = function(opts)
		local modifiable = vim.bo.modifiable
		local filetype = vim.bo.filetype
		local file = opts.file

		if modifiable and file ~= "" then
			for _, value in ipairs(filetypes_to_ignore) do
				if value == filetype then
					return
				end
			end

			vim.cmd("silent w " .. file)
		end
	end,
})
