require("telescope").setup({
	defaults = {
		sorting_strategy = "ascending",
		layout_config = {
			horizontal = {
				prompt_position = "top",
			},
		},
		mappings = {
			n = {
				["q"] = require("telescope.actions").close,
				["l"] = require("telescope.actions").select_default,
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
			find_command = vim.fn.executable("fd") == 1 and { "fd", "--type", "f", "--path-separator", "/" } or nil,

			sorting_strategy = "ascending",
			layout_config = {
				horizontal = {
					prompt_position = "top",
				},
			},
		},
		live_grep = {
			additional_args = function()
				return { "--hidden" }
			end,
			sorting_strategy = "ascending",
			layout_strategy = "vertical",
			layout_config = {
				vertical = {
					preview_cutoff = 1,
					prompt_position = "top",
					mirror = true,
				},
			},
		},
		lsp_references = {
			path_display = { "tail" },
			initial_mode = "normal",
		},
		marks = {
			initial_mode = "normal",
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
					["<cr>"] = require("telescope-undo.actions").restore,
					["<C-d>"] = require("telescope-undo.actions").yank_deletions,
					["<C-p"] = require("telescope-undo.actions").yank_additions,
				},
				n = {
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
