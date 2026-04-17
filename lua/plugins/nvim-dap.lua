return {
	"mfussenegger/nvim-dap",
	dependencies = {
		-- ui plugins to make debugging simplier
		"rcarriga/nvim-dap-ui",
		"nvim-neotest/nvim-nio",
        "theHamsta/nvim-dap-virtual-text",
	},
	config = function()
		local dap = require("dap")
		local dapui = require("dapui")
		dapui.setup()

		-- For spring boot
		-- ./gradlew <task-name> --debug-jvm
		-- For custom task
		-- ./gradlew myTask -Dorg.gradle.debug=true --no-daemon
		dap.configurations.java = {
			{
				type = "java",
				request = "attach",
				name = "Debug (Attach) - Remote",
				hostName = "127.0.0.1",
				port = 5005,
				mainClass = "ru.gpay.web.GpayWebApplication",
			},
		}

		dap.listeners.before.attach.dapui_config = function()
			dapui.open()
		end

		dap.listeners.before.launch.dapui_config = function()
			dapui.open()
		end

		-- set a vim motion for <Space> + d + t to toggle a breakpoint at the line where the cursor is currently on
		vim.keymap.set("n", "<leader>dt", dap.toggle_breakpoint, { desc = "[D]ebug [T]oggle Breakpoint" })
		-- set a vim motion for <Space> + d + s to start the debugger and launch the debugging ui
		vim.keymap.set("n", "<leader>ds", dap.continue, { desc = "[D]ebug [S]tart" })

		vim.keymap.set("n", "<leader>do", dap.step_over, { desc = "[D]ebug step [O]ver" })
		vim.keymap.set("n", "<leader>di", dap.step_into, { desc = "[D]ebug step [I]nto" })
		vim.keymap.set("n", "<leader>dx", dap.step_out, { desc = "[D]ebug step out [X]" })

		-- set a vim motion to close the debugging ui
		vim.keymap.set("n", "<leader>dc", dapui.close, { desc = "[D]ebug [C]lose" })
	end,
}
