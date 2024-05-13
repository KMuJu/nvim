return {
	"nvim-telescope/telescope.nvim",
	tag = "0.1.5",
	-- or                              , branch = '0.1.x',
	enabled = false,
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

		map("n", "<leader>sf", t.find_files, "[S]earch [F]iles")
		map("n", "<leader>sg", t.git_files, "[S]earch [G]it files")
		map("n", "<leader>sw", t.live_grep, "[S]earch [W]ord")
		map("n", "<leader>sb", t.buffers, "[S]earch [B]uffers")
		map("n", "<leader>sd", t.diagnostics, "[S]earch [D]iagnostics")
		map("n", "<leader>sh", t.help_tags, "[S]earch [H]elp tags")

		map("n", "<leader>/", function()
			-- You can pass additional configuration to telescope to change theme, layout, etc.
			t.current_buffer_fuzzy_find(require("telescope.themes").get_dropdown({
				winblend = 10,
				previewer = false,
			}))
		end, "[/] Fuzzily search in current buffer")

		-- Also possible to pass additional configuration options.
		--  See `:help telescope.builtin.live_grep()` for information about particular keys
		map("n", "<leader>s/", function()
			t.live_grep({
				grep_open_files = true,
				prompt_title = "Live Grep in Open Files",
			})
		end, "[S]earch [/] in Open Files")

		-- Shortcut for searching your neovim configuration files
		map("n", "<leader>sn", function()
			t.find_files({ cwd = vim.fn.stdpath("config") })
		end, "[S]earch [N]eovim files")
	end,
}
