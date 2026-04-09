-- return { 
--     "bluz71/vim-moonfly-colors",
--     name = "moonfly",
--     lazy = false,
--     priority = 1000 
-- }
-- return {
--   "zootedb0t/citruszest.nvim",
--   lazy = false,
--   priority = 1000,
-- }
-- return {
--     -- Shortened Github Url
--     "Mofiqul/dracula.nvim",
--     lazy = false,
--     priority = 1000,
--     config = function()
--         local dracula = require("dracula")
--         dracula.setup({
--             -- customize dracula color palette
--             colors = {
--                 bg = "#282A36",
--                 fg = "#F8F8F2",
--                 selection = "#44475A",
--                 comment = "#818EB6",
--                 red = "#FF5555",
--                 orange = "#FFB86C",
--                 yellow = "#F1FA8C",
--                 green = "#50fa7b",
--                 purple = "#BD93F9",
--                 cyan = "#8BE9FD",
--                 pink = "#FF79C6",
--                 bright_red = "#FF6E6E",
--                 bright_green = "#69FF94",
--                 bright_yellow = "#FFFFA5",
--                 bright_blue = "#D6ACFF",
--                 bright_magenta = "#FF92DF",
--                 bright_cyan = "#A4FFFF",
--                 bright_white = "#FFFFFF",
--                 menu = "#21222C",
--                 -- visual = "#3E4452",
--                 visual = "#4b5979",
--                 gutter_fg = "#4B5263",
--                 nontext = "#3B4048",
--                 white = "#ABB2BF",
--                 black = "#191A21",
--             },
--             -- show the '~' characters after the end of buffers
--             show_end_of_buffer = true, -- default false
--             -- use transparent background
--             transparent_bg = true, -- default false
--             -- set custom lualine background color
--             lualine_bg_color = "#44475a", -- default nil
--             -- set italic comment
--             italic_comment = true, -- default false
--             -- overrides the default highlights with table see `:h synIDattr`
--         })
--         -- Make sure to set the color scheme when neovim loads and configures the dracula plugin
--         vim.cmd.colorscheme("dracula")
--     end,
-- }
return {
    "ellisonleao/gruvbox.nvim",
    priority = 1000, -- Ensures it loads first
    config = function()
        -- Optional: configure gruvbox options if needed (see gruvbox documentation)
        require("gruvbox").setup({
            terminal_colors = true, -- add neovim terminal colors
            undercurl = true,
            underline = true,
            bold = true,
            italic = {
                strings = true,
                emphasis = true,
                comments = true,
                operators = false,
                folds = true,
            },
            strikethrough = true,
            invert_selection = false,
            invert_signs = false,
            invert_tabline = false,
            inverse = true, -- invert background for search, diffs, statuslines and errors
            contrast = "hard", -- can be "hard", "soft" or empty string
            palette_overrides = {},
            overrides = {},
            dim_inactive = false,
            transparent_mode = false,
        })
    end,
}
