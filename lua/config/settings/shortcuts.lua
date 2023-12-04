local shortcuts = {
	{ "Bd", "BufferLineCloseOthers" },
	{ "Bdl", "BufferLineCloseLeft" },
	{ "Bdr", "BufferLineCloseRight" },
}

for _, shortcut in ipairs(shortcuts) do
	vim.api.nvim_create_user_command(shortcut[1], shortcut[2], shortcut[3] or {})
end
