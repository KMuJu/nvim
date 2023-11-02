return {
	{
		"lewis6991/gitsigns.nvim",
		opts = {},
	},
	{
		"akinsho/git-conflict.nvim",
		commit = "2957f74",
		config = function()
			require("git-conflict").setup({
				default_mappings = true, -- disable buffer local mapping created by this plugin
				default_commands = true, -- disable commands created by this plugin
				disable_diagnostics = false, -- This will disable the diagnostics in a buffer whilst it is conflicted
				list_opener = 'copen', -- command or function to open the conflicts list
				highlights = { -- They must have background color, otherwise the default color will be used
					incoming = 'DiffAdd',
					current = 'DiffText',
				},
				debug = true,
			})
		end,
	},
	{
		"tpope/vim-fugitive",
		config = function ()
			local map = require("helpers.keys").map
			map("n", "<leader>ga", "<cmd>Git add %<cr>", "Stage the current file")
			map("n", "<leader>gb", "<cmd>Git blame<cr>", "Show the blame")
		end
	}
}
