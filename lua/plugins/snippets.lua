return {
	"chrisgrieser/nvim-scissors",
	dependencies = "nvim-telescope/telescope.nvim", -- optional
	config = function()
		local path = vim.fn.stdpath("config") .. "/snippets"
		require("scissors").setup({
			snippetDir = path,
			editSnippetPopup = {
				height = 0.4, -- relative to the window, number between 0 and 1
				width = 0.6,
				border = "rounded",
				keymaps = {
					cancel = "q",
					saveChanges = "<CR>",
					goBackToSearch = "<BS>",
					deleteSnippet = "<C-BS>",
					openInFile = "<C-o>",
					insertNextPlaceholder = "<C-t>", -- works in insert & normal mode
				},
			},
			-- `none` writes as a minified json file using `vim.encode.json`.
			-- `yq`/`jq` ensure formatted & sorted json files, which is relevant when
			-- you version control your snippets.
			jsonFormatter = "jq", -- "yq"|"jq"|"none"
		})
		-- require("luasnip.loaders.from_vscode").lazy_load { paths = { path } }
	end,
}
