return {
    {
        "NvChad/nvim-colorizer.lua", --color
        config = function ()
        	require("colorizer").setup({'*'})
        end
    },
    --rainbow
    {
        "p00f/nvim-ts-rainbow",
    },
    -- harpoon
    {
        "ThePrimeagen/harpoon",
        dependecies = {
            "nvim-lua/plenary.nvim"
        },
    },
    -- cellular automata
    {
        "eandrju/cellular-automaton.nvim"
    },
    {
        "Djancyp/better-comments.nvim",
        config = function ()
            require('better-comment').Setup()
        end
    }
}
