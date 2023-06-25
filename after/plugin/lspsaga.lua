local saga = require("lspsaga")


local quit_keys =  {"q", "<ESC>"}

saga.setup({
	finder_action_keys = {
		open = "l",
		quit = quit_keys,
		scroll_down = "<C-f>",
		scroll_up = "<C-d>", -- quit can be a table
	},
	code_action_keys = {
		quit = quit_keys,
		exec = "<CR>",
	},
	definition_action_keys = {
		quit = quit_keys,
	},
	beacon = {
		enable = false,
	},
  rename = {
    quit = "<ESC>"
  },

	finder = {
		keys = {
			expand_or_jump = { "o", "l" },
		},
	},
})
