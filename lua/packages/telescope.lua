require('telescope').setup {
	defaults = {
		file_ignore_patterns = { ".pnpm-store","build", "dist", "node_modules", ".git", "yarn.lock", "package-lock.json", "pnpm.lock", '.png', ".svg", ".jpg", ".jpeg", ".ttf", ".eoff"},
		path_display = {"truncate"}
	},
	pickers = {
		find_files = {
			hidden = true
		},
		live_grep = {
			additional_args = function(opts)
				return { "--hidden" }
			end
		},
	},
}
