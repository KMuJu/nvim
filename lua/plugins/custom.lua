return {
    {
        -- TODO: Check startup speeds
        -- If too slow, only start in config
        dir = "~/Programming/NeovimPlugins/KeymapsPlugin/",
        priority = 100,
        config = function()
            require("Keymaps").setup({name = "kasper"})
            require("helpers.keys").map("n", "<leader>sm", require("Keymaps").open, "Show keymaps")
        end,
    }
}
