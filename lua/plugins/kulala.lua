return {
    "mistweaverco/kulala.nvim",
    config = function()
        require("kulala").setup({})
    end,
    keys = {
        {
            "<leader>kr",
            function()
                require("kulala").run()
            end,
            desc = "[K]ulala rest client [R]un Запустить текущий запрос",
        },
        {
            "<leader>ka",
            function()
                require("kulala").run_all()
            end,
            desc = "[K]ulala rest client [A]ll Запустить все запросы в файле",
        },
        {
            "<leader>kp",
            function()
                require("kulala").jump_prev()
            end,
            desc = "[K]ulala rest client [P]rev Перейти к предыдущему запросу",
        },
        {
            "<leader>kn",
            function()
                require("kulala").jump_next()
            end,
            desc = "[K]ulala rest client [N]ext Перейти к следующему запросу",
        },
        {
            "<leader>ki",
            function()
                require("kulala").inspect()
            end,
            desc = "[K]ulala rest client [i]nspect Инспекция запроса (curl)",
        },
        {
            "<leader>ke",
            function()
                require("kulala").set_env()
            end,
            desc = "[K]ulala rest client [E]nv Выбрать окружение (env)",
        },
    },
}
