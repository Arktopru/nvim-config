return {
	{
		"nvim-telescope/telescope.nvim",
		-- pull a specific version of the plugin
		-- tag = '0.1.6',
		dependencies = {
			{
				-- general purpose plugin used to build user interfaces in neovim plugins
				"nvim-lua/plenary.nvim",
			},
			{
				{ "nvim-telescope/telescope-fzf-native.nvim", build = "make", lazy = true },
			},
		},
		config = function()
			-- get access to telescopes built in functions
			local builtin = require("telescope.builtin")

			-- set a vim motion to <Space> + f + f to search for files by their names
			vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "[F]ind [F]iles" })
			-- vim.keymap.set("n", "<leader>fl", builtin.current_buffer_fuzzy_find, { desc = "[F]ind in [L]ocal buffer" })
			-- set a vim motion to <Space> + f + g to search for files based on the text inside of them
			vim.keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "[F]ind by [G]rep" })
			-- set a vim motion to <Space> + f + d to search for Code Diagnostics in the current project
			vim.keymap.set("n", "<leader>fd", builtin.diagnostics, { desc = "[F]ind [D]iagnostics" })
            -- fuzzy find methods in current class
            vim.keymap.set('n', '<leader>fm', function() require('telescope.builtin').treesitter({symbols={'function', 'method'}}) end, {desc = "[F]ind [M]ethods in class"}) 

			vim.keymap.set("n", "<leader>fe", function()
				require("telescope.builtin").diagnostics({ severity = vim.diagnostic.severity.ERROR })
			end, { desc = "[F]ind diagnostics [E]rrors" })
			vim.keymap.set("n", "<leader>fa", function()
				require("telescope.builtin").diagnostics({ severity = vim.diagnostic.severity.HINT })
			end, { desc = "[F]ind diagnostics [A]dvice" })
			vim.keymap.set("n", "<leader>fw", function()
				require("telescope.builtin").diagnostics({ severity = vim.diagnostic.severity.WARN })
			end, { desc = "[F]ind diagnostics [W]arnings" })

			vim.keymap.set("n", "<leader>f0", function()
				require("telescope.builtin").diagnostics({ bufnr = 0 })
			end, { desc = "[F]ind diagnostics for buffer [0]" })
			-- set a vim motion to <Space> + f + r to resume the previous search
			vim.keymap.set("n", "<leader>fr", builtin.resume, { desc = "[F]inder [R]esume" })
			-- set a vim motion to <Space> + f + . to search for Recent Files
			vim.keymap.set("n", "<leader>f.", builtin.oldfiles, { desc = '[F]ind Recent Files ("." for repeat)' })
			-- set a vim motion to <Space> + f + b to search Open Buffers
			vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = "[F]ind Existing [B]uffers" })
			vim.keymap.set("n", "<leader>fc", builtin.commands, { desc = "[F]ind  [C]ommands" })

			vim.keymap.set("n", "<leader>lr", builtin.lsp_references, { desc = "[L]sp  [R]eferences" })
			vim.keymap.set("n", "<leader>ld", builtin.lsp_document_symbols, { desc = "[L]sp  [D]ocument symbols" })
			vim.keymap.set("n", "<leader>lw", builtin.lsp_workspace_symbols, { desc = "[L]sp  [W]orkspace symbols" })
			vim.keymap.set(
				"n",
				"<leader>li",
				builtin.lsp_implementations,
				{ desc = "[L]sp  [I]implementations under cursor" }
			)
		end,
	},
	{
		"nvim-telescope/telescope-ui-select.nvim",
		config = function()
			-- get access to telescopes navigation functions
			local actions = require("telescope.actions")
			local icons = require("config.icons")

			require("telescope").setup({
				-- use ui-select dropdown as our ui
				extensions = {
					["ui-select"] = {
						require("telescope.themes").get_dropdown({}),
					},
					fzf = {
						fuzzy = true, -- false will only do exact matching
						override_generic_sorter = true, -- override the generic sorter
						override_file_sorter = true, -- override the file sorter
						case_mode = "smart_case", -- or "ignore_case" or "respect_case"
					},
				},
				defaults = {
					wrap_results = true,
					layout_strategy = "vertical",
					layout_config = {
						width = 0.9,
					},
					prompt_prefix = icons.ui.Telescope .. " ",
					selection_caret = icons.ui.Forward .. " ",
					entry_prefix = "   ",
					initial_mode = "insert",
					selection_strategy = "reset",
					path_display = { "absolute" },
					color_devicons = true,
					vimgrep_arguments = {
						"rg",
						"--color=never",
						"--no-heading",
						"--with-filename",
						"--line-number",
						"--column",
						"--smart-case",
						"--hidden",
						"--glob=!.git/",
					},
				},
				-- set keymappings to navigate through items in the telescope io
				mappings = {
					i = {
						["<C-n>"] = actions.cycle_history_next,
						["<C-p>"] = actions.cycle_history_prev,

						["<C-j>"] = actions.move_selection_next,
						["<C-k>"] = actions.move_selection_previous,
					},
					n = {
						["<esc>"] = actions.close,
						["j"] = actions.move_selection_next,
						["k"] = actions.move_selection_previous,
						["q"] = actions.close,
					},
				},
				pickers = {
					-- diagnostics = {
					-- 	theme = "dropdown",
					-- 	line_width = "full",
					-- },
					-- live_grep = {
					-- 	theme = "dropdown",
					-- },

					grep_string = {
						theme = "dropdown",
					},

					-- find_files = {
					-- 	theme = "dropdown",
					-- 	previewer = false,
					-- 	hidden = true,
					-- 	no_ignore = true,
					-- },

					buffers = {
						theme = "dropdown",
						previewer = false,
						initial_mode = "normal",
						mappings = {
							i = {
								["<C-d>"] = actions.delete_buffer,
							},
							n = {
								["dd"] = actions.delete_buffer,
							},
						},
					},

					planets = {
						show_pluto = true,
						show_moon = true,
					},

					colorscheme = {
						enable_preview = true,
					},

					lsp_references = {
						theme = "dropdown",
						initial_mode = "normal",
					},

					lsp_definitions = {
						theme = "dropdown",
						initial_mode = "normal",
					},

					lsp_declarations = {
						theme = "dropdown",
						initial_mode = "normal",
					},

					lsp_implementations = {
						theme = "dropdown",
						initial_mode = "normal",
					},
				},
			})
			-- load the ui-select extension
			require("telescope").load_extension("ui-select")
		end,
	},
}
