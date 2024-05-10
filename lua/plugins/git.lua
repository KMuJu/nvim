local map = require("helpers.keys").map
return {
	{
		"lewis6991/gitsigns.nvim",
		opts = {},
		config = function()
			require("gitsigns").setup()
			map("n", "<leader>gp", "<cmd>Gitsigns preview_hunk<cr>", "Show git changes in hunk")
		end,
	},
	{
		"akinsho/git-conflict.nvim",
		commit = "2957f74",
		config = function()
			require("git-conflict").setup({
				default_mappings = true, -- disable buffer local mapping created by this plugin
				default_commands = true, -- disable commands created by this plugin
				disable_diagnostics = false, -- This will disable the diagnostics in a buffer whilst it is conflicted
				list_opener = "copen", -- command or function to open the conflicts list
				highlights = { -- They must have background color, otherwise the default color will be used
					incoming = "DiffAdd",
					current = "DiffText",
				},
				debug = true,
			})
		end,
	},
	-- {
	-- 	"tpope/vim-fugitive",
	-- 	enabled = false,
	-- 	config = function()
	-- 		map("n", "<leader>ga", "<cmd>Git add %<cr>", "Stage the current file")
	-- 		map("n", "<leader>gc", "<cmd>Git commit<cr>", "Git commit")
	-- 		map("n", "<leader>gb", "<cmd>Git blame<cr>", "Show the blame")
	-- 	end,
	-- },
	{
		"NeogitOrg/neogit",
		dependencies = {
			"nvim-lua/plenary.nvim", -- required
			"sindrets/diffview.nvim", -- optional - Diff integration

			-- Only one of these is needed, not both.
			"nvim-telescope/telescope.nvim", -- optional
			"ibhagwan/fzf-lua", -- optional
		},
		config = true,
	},
}
