local colors = require("custom.colors.init")

return {
	{
		"rose-pine/neovim",
		name = "rose-pine",
		priority = 70,
		config = function()
			local groups = colors.custom.groups
			local highlight_groups = colors.custom.highlight_groups
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

			local map = require("helpers.keys").map
			map("n", "<leader>cs", function()
				-- This updates rose-pine and sets colorscheme
				-- Breaks nvim-colorizer for some reason
				colors.switch()
				vim.cmd("Lazy reload rose-pine")
				vim.cmd.colorscheme(require("helpers.theme"))
				-- vim.cmd("Lazy reload nvim-colorizer.lua")
				print("Switched colors")
			end, "Switch custom colorscheme")
		end,
	},
}
