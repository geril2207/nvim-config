local create_command = vim.api.nvim_create_user_command

create_command("SRestore", function()
	require("persistence").load({ last = true })
end, {})

create_command("SSelect", function()
	require("persistence").select()
end, {})
