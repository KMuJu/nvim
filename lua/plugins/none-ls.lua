return {
	"nvimtools/none-ls.nvim",
	enabled = false,
	config = function()
		local null_ls = require("null-ls")

		null_ls.setup({
			sources = {
				null_ls.builtins.formatting.stylua,
				null_ls.builtins.completion.spell,
				null_ls.builtins.diagnostics.cmake_lint,
				null_ls.builtins.formatting.prettier.with({
					filetypes = {
						"javascript",
						"javascriptreact",
						"typescript",
						"typescriptreact",
						"vue",
						"css",
						"scss",
						"less",
						"html",
						"json",
						"jsonc",
						"yaml",
						"graphql",
						"handlebars",
					},
				}),
				null_ls.builtins.formatting.black,
				-- null_ls.builtins.formatting.ocamlformat,
			},
		})
	end,
}
