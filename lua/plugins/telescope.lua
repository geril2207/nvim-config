return {
	{
		"nvim-telescope/telescope.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
			{
				"nvim-telescope/telescope-fzf-native.nvim",
				build = "make",
			},
		},
		config = function()
			local actions = require("telescope.actions")
			local action_layout = require("telescope.actions.layout")

			require("telescope").setup({
				defaults = {
					sorting_strategy = "ascending",
					layout_config = {
						horizontal = {
							prompt_position = "top",
						},
					},
					mappings = {
						i = {
							["<ESC>"] = actions.close,
							["<M-p>"] = action_layout.toggle_preview,
							["<M-k>"] = actions.cycle_history_prev,
							["<M-j>"] = actions.cycle_history_next,
							["<C-j>"] = actions.preview_scrolling_down,
							["<C-k>"] = actions.preview_scrolling_up,
							["<C-l>"] = actions.preview_scrolling_right,
							["<C-h>"] = actions.preview_scrolling_left,
						},
						n = {
							["q"] = actions.close,
							["l"] = actions.select_default,
						},
					},
					file_ignore_patterns = {
						".pnpm-store",
						"build",
						"dist",
						"node_modules",
						".git",
						".png",
						".svg",
						".jpg",
						".mp3",
						".jpeg",
						".ttf",
						".eoff",
						".otf",
						".woff2",
						".woff",
						".eot",
					},
					path_display = { "truncate" },
				},
				pickers = {
					find_files = {
						hidden = true,
						no_ignore = false,
						find_command = vim.fn.executable("fd") == 1
								and { "fd", "--type", "f", "--path-separator", "/" }
							or nil,

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
					lsp_implementations = {
						initial_mode = "normal",
						layout_config = {
							preview_width = 80,
							mirror = true,
							width = 0.7,
						},
					},
					lsp_references = {
						show_line = false,
						path_display = { "tail" },
						file_ignore_patterns = {},
						initial_mode = "normal",
						layout_config = {
							preview_width = 80,
							mirror = true,
							width = 0.7,
						},
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
				},
			})

			require("telescope").load_extension("fzf")
			require("telescope").load_extension("neoclip")
		end,
	},

	{
		"AckslD/nvim-neoclip.lua",
		lazy = true,
		config = function()
			require("neoclip").setup({
				keys = {
					telescope = {
						i = {
							select = "<cr>",
							paste = "<c-u>",
							paste_behind = "<c-k>",
							replay = "<c-q>", -- replay a macro
							delete = "<c-d>", -- delete an entry
							edit = "<c-e>", -- edit an entry
							custom = {},
						},
						n = {
							select = "<cr>",
							paste = "p",
							--- It is possible to map to more than one key.
							-- paste = { 'p', '<c-p>' },
							paste_behind = "P",
							replay = "q",
							delete = "d",
							edit = "e",
							custom = {},
						},
					},
				},
			})
		end,
	},
	{
		"stevearc/dressing.nvim",
		config = function()
			require("dressing").setup({
				input = { enabled = true, win_options = { winblend = 0, sidescrolloff = 7 } },
				select = { enabled = true },
			})
		end,
	},
}
