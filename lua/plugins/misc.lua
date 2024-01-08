return {
    {
        "nvim-lua/plenary.nvim"
    },
    {
        "NvChad/nvim-colorizer.lua", --color
        commit = "36c610a9717cc9ec426a07c8e6bf3b3abcb139d6",
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
    },
    -- yuck eww
    "elkowar/yuck.vim",
}
