return {
	"nvim-telescope/telescope.nvim",
	tag = "0.1.5",
	-- or                              , branch = '0.1.x',
	dependencies = {
		"nvim-lua/plenary.nvim",
		-- "MunifTanjim/nui.nvim",
		{ "nvim-telescope/telescope-fzf-native.nvim", build = "make", cond = vim.fn.executable("make") == 1 },
	},
	config = function()

		local telescope = require("telescope")

		telescope.setup({
			defaults = {
                -- https://github.com/nvim-telescope/telescope.nvim/wiki/Configuration-Recipes#layouts
				layout_strategy = "flex",
				layout_config = {
					horizontal = {
						width = 0.8,
						height = 0.9,
                        preview_width = 0.6,
					},
					vertical = {
						width = 0.9,
						height = 0.9,
					},
				},
			},
		})
		-- Enable telescope fzf native, if installed
		pcall(require("telescope").load_extension, "fzf")

		local map = require("helpers.keys").map
		local t = require("telescope.builtin")

		map("n", "<leader>sf", t.find_files, "Find files")
		map("n", "<leader>sw", t.live_grep, "Find word")
		map("n", "<leader>sb", t.buffers, "Find buffers")
		map("n", "<leader>sd", t.diagnostics, "Find diagnostics")
	end,
}
