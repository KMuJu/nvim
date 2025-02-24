return {
	"nvim-neo-tree/neo-tree.nvim",
	-- lazy = true,
	branch = "v2.x",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-tree/nvim-web-devicons",
		"MunifTanjim/nui.nvim",
	},
	config = function()
		local map = require("helpers.keys").map
		require("neo-tree").setup()
		map({ "n", "v" }, "<leader>e", "<cmd>Neotree filesystem toggle<cr>", "Toggle file explorer")
	end,
}
