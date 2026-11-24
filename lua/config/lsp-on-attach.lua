local on_attach = function(bufnr, client)
	local lsp_map = require("helpers.keys").lsp_map
	lsp_map("<leader>lr", vim.lsp.buf.rename, bufnr, "Rename symbol")
	lsp_map("<leader>la", vim.lsp.buf.code_action, bufnr, "Code action")
	lsp_map("<leader>ld", vim.lsp.buf.type_definition, bufnr, "Type definition")
	lsp_map("<leader>ls", require("fzf-lua").lsp_document_symbols, bufnr, "Document symbols")
	-- lsp_map("<leader>ls", require("telescope.builtin").lsp_document_symbols, bufnr, "Document symbols")

	lsp_map("gd", vim.lsp.buf.definition, bufnr, "Goto Definition")
	lsp_map("gr", require("fzf-lua").lsp_references, bufnr, "Goto References")
	lsp_map("gI", require("fzf-lua").lsp_implementations, bufnr, "Goto Implementation")
	lsp_map("K", vim.lsp.buf.hover, bufnr, "Hover Documentation")
	lsp_map("gD", vim.lsp.buf.declaration, bufnr, "Goto Declaration")
	vim.keymap.set("i", "<C-Space>", vim.lsp.buf.signature_help, { desc = "Signature help", buffer = bufnr })

	-- Inlay hints
	lsp_map("<leader>lh", function()
		vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
	end, bufnr, "Toggle inline [H]ints")

	-- Create a command `:Format` local to the LSP buffer
	vim.api.nvim_buf_create_user_command(bufnr, "Format", function(_)
		vim.lsp.buf.format()
	end, { desc = "Format current buffer with LSP" })

	lsp_map("<leader>ff", "<cmd>Format<cr>", bufnr, "Format")
	require("helpers.keys").map("v", "<leader>fv", vim.lsp.buf.format, "Format selection")

	vim.lsp.config("*", {
		hover = {
			border = "rounded",
		},
	})

	if client.server_capabilities.documentSymbolProvider then
		require("nvim-navic").attach(client, bufnr)
	end

	-- Attach and configure vim-illuminate
	require("illuminate").on_attach(client)
end

return on_attach
