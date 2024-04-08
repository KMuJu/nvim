return {
	"neovim/nvim-lspconfig",
	dependencies = {
		"williamboman/mason.nvim",
		"williamboman/mason-lspconfig.nvim",
		-- "j-hui/fidget.nvim",
		"folke/neodev.nvim",
		"RRethy/vim-illuminate",
		"hrsh7th/cmp-nvim-lsp",
	},
	config = function()
		local status, lsp = pcall(require, "lspconfig")
		local servers = {
			"lua_ls",
			-- "pylsp",
			"pyright",
			-- cpp
			"clangd",
			-- "cmakelint",
			-- "cmakelang",

			"tsserver",
			"svelte",
			"html",
			"cssls",
			"cmake",
			"bashls",
			"ocamllsp",

			"jdtls", -- java
			"lemminx", --

			"gopls",
			"dockerls",
			"templ",
		}
		require("mason").setup()
		require("mason-lspconfig").setup({
			ensure_installed = servers,
			automatic_installation = true,
		})

		require("helpers.keys").map("n", "<leader>M", "<cmd>Mason<cr>", "Show Mason")

		require("neodev").setup()

		-- Set up cool signs for diagnostics
		local signs = { Error = "E ", Warn = " ", Hint = "H ", Info = " " }
		for type, icon in pairs(signs) do
			local hl = "DiagnosticSign" .. type
			vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
		end

		-- Diagnostic config
		local config = require("custom.functions.diagnostics").diag1
		vim.diagnostic.config(config)

		local on_attach = function(client, bufnr)
			local lsp_map = require("helpers.keys").lsp_map
			lsp_map("<leader>lr", vim.lsp.buf.rename, bufnr, "Rename symbol")
			lsp_map("<leader>la", vim.lsp.buf.code_action, bufnr, "Code action")
			lsp_map("<leader>ld", vim.lsp.buf.type_definition, bufnr, "Type definition")
			lsp_map("<leader>ls", require("telescope.builtin").lsp_document_symbols, bufnr, "Document symbols")

			lsp_map("gd", vim.lsp.buf.definition, bufnr, "Goto Definition")
			lsp_map("gr", require("telescope.builtin").lsp_references, bufnr, "Goto References")
			lsp_map("gI", vim.lsp.buf.implementation, bufnr, "Goto Implementation")
			lsp_map("K", vim.lsp.buf.hover, bufnr, "Hover Documentation")
			lsp_map("gD", vim.lsp.buf.declaration, bufnr, "Goto Declaration")

			-- Create a command `:Format` local to the LSP buffer
			vim.api.nvim_buf_create_user_command(bufnr, "Format", function(_)
				vim.lsp.buf.format()
			end, { desc = "Format current buffer with LSP" })

			lsp_map("<leader>ff", "<cmd>Format<cr>", bufnr, "Format")
			require("helpers.keys").map("v", "<leader>fv", vim.lsp.buf.format, "Format selection")

			vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
				border = "rounded",
			})

			-- Attach and configure vim-illuminate
			require("illuminate").on_attach(client)
		end

		local capabilities = vim.lsp.protocol.make_client_capabilities()
		capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

		local lspconfig = require("lspconfig")
		for _, server in pairs(servers) do
			lspconfig[server].setup({
				capabilities = capabilities,
				on_attach = on_attach,
			})
		end

		-- Lua
		lspconfig["lua_ls"].setup({
			on_attach = on_attach,
			capabilities = capabilities,
			settings = {
				Lua = {
					completion = {
						callSnippet = "Replace",
					},
					diagnostics = {
						globals = { "vim" },
					},
					workspace = {
						library = {
							[vim.fn.expand("$VIMRUNTIME/lua")] = true,
							[vim.fn.stdpath("config") .. "/lua"] = true,
						},
					},
				},
			},
		})

		-- Python
		lspconfig["pylsp"].setup({
			on_attach = on_attach,
			capabilities = capabilities,
			settings = {
				pylsp = {
					plugins = {
						flake8 = {
							enabled = true,
							maxLineLength = 88, -- Black's line length
						},
						-- Disable plugins overlapping with flake8
						pycodestyle = {
							enabled = false,
						},
						mccabe = {
							enabled = false,
						},
						pyflakes = {
							enabled = false,
						},
						-- Use Black as the formatter
						autopep8 = {
							enabled = false,
						},
					},
				},
			},
		})

		lspconfig["clangd"].setup({
			on_attach = function(client, bufnr)
				client.server_capabilities.signatureHelpProvider = false
				on_attach(client, bufnr)
			end,
		})

		require("lspconfig")["ocamllsp"].setup({
			cmd = { "ocamllsp" },
			filetypes = { "ocaml", "ocaml.menhir", "ocaml.interface", "ocaml.ocamllex", "reason", "dune" },
			root_dir = lsp.util.root_pattern(
				"*.opam",
				"esy.json",
				"package.json",
				".git",
				"dune-project",
				"dune-workspace"
			),
			on_attach = on_attach,
			capabilities = capabilities,
		})
	end,
}
