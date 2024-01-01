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
		local Layout = require("nui.layout")
		local Popup = require("nui.popup")

		local telescope = require("telescope")
		local TSLayout = require("telescope.pickers.layout_strategies")

		local function make_popup(options)
			local popup = Popup(options)
			function popup.border:change_title(title)
				popup.border.set_text(popup.border, "top", title)
			end

			return TSLayout.Window(popup)
		end

		telescope.setup({
			defaults = {
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
