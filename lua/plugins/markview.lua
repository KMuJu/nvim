return {
	"OXY2DEV/markview.nvim",
	-- lazy = false, -- Recommended
	ft = "markdown", -- If you decide to lazy-load anyway

	dependencies = {
		-- You will not need this if you installed the
		-- parsers manually
		-- Or if the parsers are in your $RUNTIMEPATH
		"nvim-treesitter/nvim-treesitter",

		"nvim-tree/nvim-web-devicons",
	},
	config = function()
		local map = require("helpers.keys").map
		map("n", "<leader>m", "<cmd>Markview toggle<CR>", "Toggle markdown view")
		require("markview").setup({
			markdown = {
				list_items = {
					shift_width = function(buffer, item)
						--- Reduces the `indent` by 1 level.
						---
						---         indent                      1
						--- ------------------------- = 1 ÷ --------- = new_indent
						--- indent * (1 / new_indent)       new_indent
						---
						local parent_indnet = math.max(1, item.indent - vim.bo[buffer].shiftwidth)

						return item.indent * (1 / (parent_indnet * 2))
					end,
					marker_minus = {
						add_padding = false,
					},
					marker_star = {
						add_padding = false,
					},
				},
			},
		})
	end,
}
