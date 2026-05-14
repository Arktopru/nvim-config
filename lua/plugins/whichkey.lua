return {
    "folke/which-key.nvim",
    event = "VimEnter",
    config = function()
        -- gain access to the which key plugin
        local which_key = require("which-key")

        -- call the setup function with default properties
        which_key.setup()

        which_key.add({
            { "<leader>/", group = "Comments" },
            { "<leader>b", group = "[B]uffers" },
            { "<leader>c", group = "[C]ode" },
            { "<leader>d", group = "[D]ebug" },
            { "<leader>e", group = "[E]xplorer" },
            { "<leader>f", group = "[F]ind" },
            { "<leader>g", group = "[G]it" },
            { "<leader>J", group = "[J]ava" },
            { "<leader>J", group = "[K]ulala" },
            { "<leader>r", group = "[R]efactor" },
            { "<leader>t", group = "[T]est" },
            { "<leader>w", group = "[W]indow" },
            { "<leader>o", group = "[O]pen" },
            { "<leader>q", group = "[Q] diff" },
        })
    end,
}
