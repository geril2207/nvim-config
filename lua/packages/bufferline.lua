local close_func = function(bufnum)
	local bufdelete_avail, bufdelete = pcall(require, "bufdelete")
	if bufdelete_avail then
		bufdelete.bufdelete(bufnum, true)
	else
		vim.cmd.bdelete { args = { bufnum }, bang = true }
	end
end
require("bufferline").setup {
	options = {
		diagnostics = "nvim_lsp",
		show_close_icon = false,
		close_command = close_func,
		right_mouse_command = close_func,
		max_name_length = 14,
		max_prefix_length = 13,
		tab_size = 20,
		offsets = {
			{
				filetype = "NvimTree",
				text_align = "left",
				separator = true,
			}

		},
		diagnostics_indicator = function(count, level, diagnostics_dict, context)
			local icon = level:match("error") and " " or " "
			return " " .. icon .. count
		end

	}
}
