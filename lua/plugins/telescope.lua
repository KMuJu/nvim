return {
	'nvim-telescope/telescope.nvim', tag = '0.1.3',
	-- or                              , branch = '0.1.x',
	dependencies = { 
        'nvim-lua/plenary.nvim',
        { "nvim-telescope/telescope-fzf-native.nvim", build = "make", cond = vim.fn.executable("make") == 1 },
    },
    config = function()
			require("telescope").setup({
				defaults = {
					mappings = {
						i = {
							-- ["<C-u>"] = false,
							-- ["<C-d>"] = false,
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

    end
}
