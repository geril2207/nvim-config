local old_notify = vim.notify

function vim.notify(msg, level)
	if msg:find("WARNING: vim.treesitter.get_parser") or msg:find("position_encoding param is required") then
		return
	end
	old_notify(msg, level)
end
