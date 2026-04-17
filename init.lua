-- Declare the path where lazy will clone plugin code
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

-- Check to see if lazy itself has been cloned, if not clone it into the lazy.nvim directory
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end

-- Add the path to the lazy plugin repositories to the vim runtime path
vim.opt.rtp:prepend(lazypath)

-- Declare a few options for lazy
local opts = {
	change_detection = {
		-- Don't notify us every time a change is made to the configuration
		notify = false,
	},
	checker = {
		-- Automatically check for package updates
		enabled = true,
		-- Don't spam us with notification every time there is an update available
		notify = false,
	},
}

-- Load the options from the config/options.lua file
require("config.options")
-- Load the keymaps from the config/keymaps.lua file
require("config.keymaps")
-- Load the auto commands from the config/autocmds.lua file
-- require("config.autocmds")
-- Setup lazy, this should always be last
-- Tell lazy that all plugin specs are found in the plugins directory
-- Pass it the options we specified above
require("lazy").setup("plugins", opts)


vim.o.background = "dark" -- or "light" for light mode
vim.cmd([[colorscheme gruvbox]])

vim.filetype.add({
	extension = {
		ftl = "html",
		"css",
		"freemarker", -- Treat .myhtml files as html
	},
})

-- Add a custom extension to be detected as 'html'
-- Open the current file in the default system browser
vim.keymap.set("n", "<leader>ob", function()
	vim.ui.open(vim.fn.expand("%:p"))
end, { desc = "[O]pen file in system default [B]rowser" })

-- Настройки для Neovide
--
if vim.g.neovide then
	vim.o.guifont = "JetBrainsMono Nerd Font Mono:h15"

	-- vim.g.neovide_progress_bar_enabled = true
	-- vim.g.neovide_progress_bar_height = 5.0
	-- vim.g.neovide_progress_bar_animation_speed = 200.0
	-- vim.g.neovide_progress_bar_hide_delay = 0.2

	-- vim.g.neovide_text_gamma = 0.0
	-- vim.g.neovide_text_contrast = 0.5

	local function save()
		vim.cmd.write()
	end
	local function copy()
		vim.cmd([[normal! "+y]])
	end
	local function paste()
		vim.api.nvim_paste(vim.fn.getreg("+"), true, -1)
	end

	vim.keymap.set({ "n", "i", "v" }, "<D-s>", save, { desc = "Save" })
	vim.keymap.set("v", "<D-c>", copy, { silent = true, desc = "Copy" })
	vim.keymap.set({ "n", "i", "v", "c", "t" }, "<D-v>", paste, { silent = true, desc = "Paste" })

	vim.g.neovide_position_animation_length = 0
	vim.g.neovide_cursor_animation_length = 0.00
	vim.g.neovide_cursor_trail_size = 0
	vim.g.neovide_cursor_animate_in_insert_mode = false
	vim.g.neovide_cursor_animate_command_line = false
	vim.g.neovide_scroll_animation_far_lines = 0
	vim.g.neovide_scroll_animation_length = 0.00
end
