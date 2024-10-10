return {
	"stevearc/dressing.nvim",
	opts = {
		select = {
			enabled = false,
			backend = "builtin",
			builtin = {
				min_height = 2,
				mappings = {
					["q"] = "Close",
				},
			},
		},
	},
}
