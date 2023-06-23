require("telescope").setup({
	defaults = {
		mappings = {
			n = {
				["q"] = require("telescope.actions").close,
			},
		},
		file_ignore_patterns = {
			".pnpm-store",
			"build",
			"dist",
			"node_modules",
			".git",
			"yarn.lock",
			"package-lock.json",
			"pnpm.lock",
			".png",
			".svg",
			".jpg",
			".jpeg",
			".ttf",
			".eoff",
		},
		path_display = { "truncate" },
	},
	pickers = {
		find_files = {
			hidden = true,
			no_ignore = false,
		},
		live_grep = {
			additional_args = function()
				return { "--hidden" }
			end,
		},
	},
	extensions = {
		fzf = {
			fuzzy = true, -- false will only do exact matching
			override_generic_sorter = true, -- override the generic sorter
			override_file_sorter = true, -- override the file sorter
			case_mode = "smart_case", -- or "ignore_case" or "respect_case"
			-- the default case_mode is "smart_case"
		},

		undo = {
			mappings = {
				i = {
					-- IMPORTANT: Note that telescope-undo must be available when telescope is configured if
					-- you want to replicate these defaults and use the following actions. This means
					-- installing as a dependency of telescope in it's `requirements` and loading this
					-- extension from there instead of having the separate plugin definition as outlined
					-- above.
					["<cr>"] = require("telescope-undo.actions").restore,
					["<C-d>"] = require("telescope-undo.actions").yank_deletions,
					["<C-p"] = require("telescope-undo.actions").yank_additions,
				},
				n = {
					-- IMPORTANT: Note that telescope-undo must be available when telescope is configured if
					-- you want to replicate these defaults and use the following actions. This means
					-- installing as a dependency of telescope in it's `requirements` and loading this
					-- extension from there instead of having the separate plugin definition as outlined
					-- above.
					["y"] = require("telescope-undo.actions").yank_additions,
					["Y"] = require("telescope-undo.actions").yank_deletions,
					["u"] = require("telescope-undo.actions").restore,
				},
			},
		},
	},
})
require("telescope").load_extension("fzf")
require("telescope").load_extension("undo")
