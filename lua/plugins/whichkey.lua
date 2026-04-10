return {
    "folke/which-key.nvim",
    event = "VimEnter",
    config = function()
        -- gain access to the which key plugin
        local which_key = require("which-key")

        -- call the setup function with default properties
        which_key.setup()

        -- Register prefixes for the different key mappings we have setup previously
        -- which_key.register({
        --     ['<leader>/'] = {name = "Comments", _ = 'which_key_ignore'},
        --     ['<leader>c'] = { name = '[C]ode', _ = 'which_key_ignore' },
        --     ['<leader>d'] = {name = '[D]ebug' , _ = 'which_key_ignore' },
        --     ['<leader>e'] = {name = '[E]xplorer', _ = 'which_key_ignore'},
        --     ['<leader>f'] = { name = '[F]ind', _ = 'which_key_ignore' },
        --     ['<leader>g'] = { name = '[G]it', _ = 'which_key_ignore' },
        --     ['<leader>J'] = { name = '[J]ava', _ = 'which_key_ignore' },
        --     ['<leader>t'] = { name = '[T]ab', _ = 'which_key_ignore'},
        --     ['<leader>w'] = {name = '[W]indow', _ = 'which_key_ignore'}
        -- })
        which_key.add({
            { "<leader>/", group = "Comments" },
            { "<leader>b", group = "[B]uffers" },
            { "<leader>c", group = "[C]ode" },
            { "<leader>d", group = "[D]ebug" },
            { "<leader>e", group = "[E]xplorer" },
            { "<leader>f", group = "[F]ind" },
            { "<leader>g", group = "[G]it" },
            { "<leader>J", group = "[J]ava" },
            { "<leader>r", group = "[R]efactor" },
            { "<leader>t", group = "[T]ab" },
            { "<leader>w", group = "[W]indow" },
            { "<leader>o", group = "[O]pen" },
        })
    end,
}
