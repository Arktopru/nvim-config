return {
	"nvim-java/nvim-java",
	config = function()
		require("java").setup({
			-- Startup checks
			checks = {
				nvim_version = true, -- Check Neovim version
				nvim_jdtls_conflict = true, -- Check for nvim-jdtls conflict
			},
			lombok = {
				enable = true,
			},
			java_test = {
				enable = true,
			},
			java_debug_adapter = {
				enable = true,
			},
			spring_boot_tools = {
				enable = true,
			},
			jdk = {
				auto_install = true,
				version = "25",
			},
			log = {
				use_console = true,
				use_file = true,
				level = "info",
				log_file = vim.fn.stdpath("state") .. "/nvim-java.log",
				max_lines = 1000,
				show_location = false,
			},
			root_markers = {
				"settings.gradle",
				"settings.gradle.kts",
				"pom.xml",
				"build.gradle",
				"mvnw",
				"gradlew",
				"build.gradle",
				"build.gradle.kts",
			},
		})
		vim.lsp.enable("jdtls")
	end,
}
