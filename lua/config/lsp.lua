local servers = {
	lua_ls = {
		settings = {
			Lua = {
				completion = {
					callSnippet = "Replace",
				},
				diagnostics = {
					globals = { "vim" },
				},
				workspace = {
					-- library = lualib,
					-- library = {
					-- 	[vim.fn.expand("$VIMRUNTIME/lua")] = true,
					-- 	[vim.fn.stdpath("config") .. "/lua"] = true,
					-- },
					library = vim.api.nvim_get_runtime_file("lua", true),
				},
			},
		},
	},
	pyright = {},
	clangd = {
		-- cmd = { "clangd", unpack(require("custom.clangd").flags) },
		-- TODO: Could include cmd, but not sure those were all relevant flags.
		--    looks like something i would have added while i was floundering
		init_options = { clangdFileStatus = true },

		filetypes = { "c", "cpp" },
	},

	ts_ls = {
		server_capabilities = {
			documentFormattingProvider = false,
		},
	},
	svelte = {},
	html = {},
	cssls = {},
	cmake = {},
	bashls = {},
	ocamllsp = {
		cmd = { "ocamllsp" },
		settings = {
			codelens = { enable = true },
			inlayHints = { enable = true },
			syntaxDocumentation = { enable = true },
		},

		server_capabilities = { semanticTokensProvider = false },
	},

	jdtls = {
		settings = {
			java = {
				configuration = {
					runtimes = {
						{
							name = "JavaSE-21",
							path = "/usr/sbin/java",
							default = true,
						},
					},
				},
			},
		},
	}, -- java
	lemminx = {}, --

	gopls = {},
	dockerls = {},
	templ = {},
	elixirls = {
		cmd = { "/home/Kasper/.local/share/nvim/mason/bin/elixir-ls" },
		root_dir = require("lspconfig.util").root_pattern({ "mix.exs" }),
		server_capabilities = {
			-- completionProvider = true,
			-- definitionProvider = false,
			documentFormattingProvider = false,
		},
	},
	mesonlsp = {},
	glsl = {},
}

require("mason").setup()
-- WARNING: This will automatically enable all lsp's installed through mason
-- This kind of makes the loop further down useless
-- rust_analyzer is excluded since rustaceanvim will start it
require("mason-lspconfig").setup({
	ensure_installed = servers,
	automatic_enable = {
		exclude = { "rust_analyzer" },
	},
})

require("helpers.keys").map("n", "<leader>M", "<cmd>Mason<cr>", "Show Mason")

-- Diagnostic config
vim.diagnostic.config(require("custom.functions.diagnostics").diag1)

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

for name, config in pairs(servers) do
	if config == true then
		config = {}
	end
	config = vim.tbl_deep_extend("force", {}, {
		capabilities = capabilities,
	}, config)

	-- lspconfig[name].setup(config)
	vim.lsp.enable(name)
	vim.lsp.config(name, config)
end

local on_attach = require("config.lsp-on-attach")

vim.api.nvim_create_autocmd("LspAttach", {
	callback = function(args)
		local bufnr = args.buf
		local client = assert(vim.lsp.get_client_by_id(args.data.client_id), "must have valid client")
		on_attach(bufnr, client)
	end,
})
