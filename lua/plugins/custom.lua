local map = require("helpers.keys").map
return {
	-- {
	-- 	-- TODO: Check startup speeds
	-- 	-- If too slow, only start in config
	-- 	dir = "~/Programming/NeovimPlugins/KeymapsPlugin/",
	-- 	priority = 100,
	-- 	config = function()
	-- 		require("Keymaps").setup({ name = "kasper" })
	-- 		require("helpers.keys").map("n", "<leader>sm", require("Keymaps").open, "Show keymaps")
	-- 	end,
	-- },
	{
		dir = "~/Programming/NeovimPlugins/Filetree.nvim/",
		priority = 100,
		config = function()
			require("Filetree").setup({})
			map("n", "<leader>po", require("Filetree").open, "Open custom filetree")
			map("n", "<leader>pp", require("Filetree").togglePreview, "Open custom filetree")
		end,
	},
}
