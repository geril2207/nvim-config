vim.filetype.add({
	pattern = {
		["%.env%.[%w_.-]+"] = "sh",
	},
})

vim.api.nvim_create_autocmd("FileType", {
	pattern = "*",
	callback = function()
		vim.opt.formatoptions = vim.opt.formatoptions - "o" - "c"
	end,
})
