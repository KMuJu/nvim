local colors = require("custom.colors.rose-pine")

return {
	{
		"rose-pine/neovim",
		name = "rose-pine",
		priority = 70,
		config = function()
			local groups = colors.groups
			local highlight_groups = colors.highlight_groups
			require("rose-pine").setup({
				--- @usage 'auto'|'main'|'moon'|'dawn'
				variant = "moon",
				--- @usage 'main'|'moon'|'dawn'
				dark_variant = "moon",
				bold_vert_split = false,
				dim_nc_background = false,
				disable_background = false,
				disable_float_background = false,
				disable_italics = false,
				extend_background_behind_borders = false,

				--- @usage string hex value or named color from rosepinetheme.com/palette
				groups = groups,

				-- Change specific vim highlight groups
				-- https://github.com/rose-pine/neovim/wiki/Recipes
				highlight_groups = highlight_groups,
			})
		end,
	},
	{
		"folke/tokyonight.nvim",
		lazy = false,
		priority = 1000,
		opts = {},
	},
}
