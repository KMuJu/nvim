return {
	"ibhagwan/fzf-lua",
	config = function()
		local fzf = require("fzf-lua")
		fzf.setup({
			winopts = {
				preview = {
					delay = 0,
				},
			},
			keymap = {
				fzf = {
					["ctrl-q"] = "select-all+accept",
				},
			},
		})

		local map = require("helpers.keys").map

		map("n", "<leader>sf", fzf.files, "[S]earch [F]iles")
		map("n", "<leader>sg", fzf.git_files, "[S]earch [G]it files")
		map("n", "<leader>sw", fzf.live_grep, "[S]earch [W]ord")
		map("n", "<leader>sb", fzf.buffers, "[S]earch [B]uffers")
		map("n", "<leader>sd", fzf.diagnostics_workspace, "[S]earch [D]iagnostics")
		map("n", "<leader>sh", fzf.helptags, "[S]earch [H]elp tags")

		map("n", "<leader>/", fzf.lgrep_curbuf, "[/] Fuzzily sarch in current buffer")
		map("n", "<leader>sn", function()
			fzf.lgrep_curbuf({ cwd = vim.fn.stdpath("config") })
		end, "[/] Fuzzily sarch in current buffer")
	end,
}
