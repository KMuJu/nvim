return {
	"neovim/nvim-lspconfig",
	dependencies = {
		"williamboman/mason.nvim",
		"williamboman/mason-lspconfig.nvim",
		-- "j-hui/fidget.nvim",
		"folke/lazydev.nvim",
		"RRethy/vim-illuminate",
		"hrsh7th/cmp-nvim-lsp",
	},
	config = function()
		require("config.lsp")
	end,
}
