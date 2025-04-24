return {
    {
        "rcasia/neotest-java",
        ft = "java",
        dependencies = {
            "mfussenegger/nvim-jdtls",
            "mfussenegger/nvim-dap",           -- for the debugger
            "rcarriga/nvim-dap-ui",            -- recommended
            "theHamsta/nvim-dap-virtual-text", -- recommended
        },
    },
    {
        "nvim-neotest/neotest",
        dependencies = {
            "nvim-neotest/nvim-nio",
            "nvim-lua/plenary.nvim",
            "antoinemadec/FixCursorHold.nvim",
            "nvim-treesitter/nvim-treesitter",
            { "fredrikaverpil/neotest-golang", version = "*" }, -- Installation
        },
        requires = {
            { "fredrikaverpil/neotest-golang", version = "*" }, -- Installation
        },
        -- opts = {
        --     adapters = {
        --         ["neotest-java"] = {
        --             -- config here
        --         },
        --         require("neotest-go"),
        --         -- ["neotest-golang"] = require("neotest-golang")({})
        --     },
        -- },
        config = function()
            local neotest = require("neotest")
            neotest.setup({
                adapters = {
                    require("neotest-java")({
                        ignore_wrapper = true,
                    }),
                    require("neotest-golang")({}),
                },
            })
            vim.keymap.set("n", "<leader>tt", function()
                neotest.run.run()
            end, { desc = "Run nearest test" })
            vim.keymap.set("n", "<leader>tT", function()
                neotest.run.run({ strategy = "dap" })
            end, { desc = "Run nearest test with dap" })
        end
    },
}
