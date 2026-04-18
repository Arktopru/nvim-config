-- Actions from nvim java
-- quickassist
-- refactor.assign.field
-- refactor.assign.variable
-- refactor.change.signature
-- refactor.extract.constant
-- refactor.extract.field
-- refactor.extract.function
-- refactor.extract.interface
-- refactor.extract.variable
-- refactor.introduce.parameter
-- refactor.move
-- source.generate
-- source.generate.accessors
-- source.generate.constructors
-- source.generate.delegateMethods
-- source.generate.finalModifiers
-- source.generate.hashCodeEquals
-- source.generate.toString
-- source.organizeImports
-- source.overrideMethods
-- source.sortMembers

return {
	{
		"williamboman/mason.nvim",
		config = function()
			-- setup mason with default properties
			require("mason").setup({
				ui = {
					border = "rounded",
				},
			})
		end,
	},
	-- mason lsp config utilizes mason to automatically ensure lsp servers you want installed are installed
	{
		"williamboman/mason-lspconfig.nvim",
		config = function()
			-- ensure that we have lua language server, typescript launguage server, java language server, and java test language server are installed
			require("mason-lspconfig").setup({
				ensure_installed = {
					"lua_ls",
					"ts_ls",
					"cssls",
					"html",
					"jdtls",
					"jsonls",
					"groovyls",
					"pylsp",
					"bashls",
                    "gradle_ls",
				},
			})
		end,
	},
	-- mason nvim dap utilizes mason to automatically ensure debug adapters you want installed are installed, mason-lspconfig will not automatically install debug adapters for us
	{
		"jay-babu/mason-nvim-dap.nvim",
		config = function()
			-- ensure the java debug adapter is installed
			require("mason-nvim-dap").setup({
				ensure_installed = {
					"java-debug-adapter",
					"java-test",
				},
			})
		end,
	},
	-- utility plugin for configuring the java language server for us
	{
	    "mfussenegger/nvim-jdtls",
	    dependencies = {
	        "mfussenegger/nvim-dap",
	        "ray-x/lsp_signature.nvim",
	    },
	},
	{
		"ray-x/lsp_signature.nvim",
		config = function()
			require("lsp_signature").setup()
		end,
	},
	{
		"neovim/nvim-lspconfig",
		config = function()
			local icons = require("config.icons")
			local capabilities = require("cmp_nvim_lsp").default_capabilities()
			vim.lsp.config("lua_ls", capabilities)
			vim.lsp.config("ts_ls", capabilities)
			vim.lsp.config("cssls", capabilities)
			vim.lsp.config("html", capabilities)
			vim.lsp.config("jsonls", capabilities)
			vim.lsp.config("groovyls", capabilities)
			vim.lsp.config("pylsp", capabilities)
			vim.lsp.config("bashls", capabilities)
            vim.lsp.config("gradle_ls", capabilities)

			local default_diagnostic_config = {
				signs = {
					active = true,
					values = {
						{ name = "DiagnosticSignError", text = icons.diagnostics.Error },
						{ name = "DiagnosticSignWarn", text = icons.diagnostics.Warning },
						{ name = "DiagnosticSignHint", text = icons.diagnostics.Hint },
						{ name = "DiagnosticSignInfo", text = icons.diagnostics.Information },
					},
				},
				virtual_text = false,
				update_in_insert = false,
				underline = true,
				severity_sort = true,
				float = {
					focusable = true,
					style = "minimal",
					border = "rounded",
					source = "always",
					header = "",
					prefix = "",
				},
			}

			vim.diagnostic.config(default_diagnostic_config)

			for _, sign in ipairs(vim.tbl_get(vim.diagnostic.config(), "signs", "values") or {}) do
				vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = sign.name })
			end

			-- Set vim motion for <Space> + c + h to show code documentation about the code the cursor is currently over if available
			vim.keymap.set("n", "<leader>ch", vim.lsp.buf.hover, { desc = "[C]ode [H]over Documentation" })
			-- Set vim motion for <Space> + c + d to go where the code/variable under the cursor was defined
			vim.keymap.set("n", "<leader>cd", vim.lsp.buf.definition, { desc = "[C]ode Goto [D]efinition" })
			-- Set vim motion for <Space> + c + a for display code action suggestions for code diagnostics in both normal and visual mode
			vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, { desc = "[C]ode [A]ctions" })
			-- Set vim motion for <Space> + c + r to display references to the code under the cursor
			vim.keymap.set(
				"n",
				"<leader>cr",
				require("telescope.builtin").lsp_references,
				{ desc = "[C]ode Goto [R]eferences" }
			)
			-- Set vim motion for <Space> + c + i to display implementations to the code under the cursor
			vim.keymap.set(
				"n",
				"<leader>ci",
				require("telescope.builtin").lsp_implementations,
				{ desc = "[C]ode Goto [I]mplementations" }
			)
			-- Set a vim motion for <Space> + c + <Shift>R to smartly rename the code under the cursor
			vim.keymap.set("n", "<leader>cR", vim.lsp.buf.rename, { desc = "[C]ode [R]ename" })
			-- Set a vim motion for <Space> + c + <Shift>D to go to where the code/object was declared in the project (class file)
			vim.keymap.set("n", "<leader>cD", vim.lsp.buf.declaration, { desc = "[C]ode Goto [D]eclaration" })
			vim.keymap.set("n", "<leader>co", function()
				vim.lsp.buf.code_action({
					context = { only = { "source.organizeImports" } },
					apply = true,
				})
			end, { desc = "[C]ode [O]rganize imports" })
			vim.keymap.set("n", "<leader>cq", function()
				vim.lsp.buf.code_action({
					context = { only = { "quickassist" } },
					apply = true,
				})
			end, { desc = "[C]ode [Q]uick assist" })
			vim.keymap.set("n", "<leader>cg", function()
				vim.lsp.buf.code_action({
					context = { only = { "source.generate" } },
					apply = true,
				})
			end, { desc = "[C]ode [G]enerate" })
			vim.keymap.set("n", "<leader>cm", function()
				vim.lsp.buf.code_action({
					context = { only = { "refactor.extract_method" } },
					apply = true,
				})
			end, { desc = "[C]ode extract [M]ethod from cursor" })
			vim.keymap.set("n", "<leader>rm", function()
				vim.lsp.buf.code_action({
					context = { only = { "refactor.move" } },
					apply = true,
				})
			end, { desc = "[R]efactor [M]ove" })
		end,
	},
}
