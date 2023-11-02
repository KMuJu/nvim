return {
    "steelsojka/pears.nvim",
    config = function ()
        require("pears").setup()
        -- require("pears").setup(function (conf)
        --     conf.preset("tag-matching")
        -- end)
    end
}
