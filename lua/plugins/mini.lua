return {
	{
		"echasnovski/mini.files",
		version = false,
		config = function()
			require("mini.files").setup()
		end,
	},
	{
		"echasnovski/mini.ai",
		version = false,
		opts = {
			n_lines = 100,
		},
	},
}
