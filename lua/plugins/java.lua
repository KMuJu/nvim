return {
	--- https://github.com/AstroNvim/astrocommunity/blob/main/lua/astrocommunity/pack/java/init.lua
	"mfussenegger/nvim-jdtls",
	ft = { "java" },
	-- init = function() astronvim.lsp.skip_setup = utils.list_insert_unique(astronvim.lsp.skip_setup, "jdtls") end,
	dependencies = { "williamboman/mason-lspconfig.nvim" },
	opts = function(_, opts)
		-- use this function notation to build some variables
		local root_markers = { ".git", "mvnw", "gradlew", "pom.xml", "build.gradle", ".project" }
		local root_dir = require("jdtls.setup").find_root(root_markers)
		-- calculate workspace dir
		local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")
		local workspace_dir = vim.fn.stdpath("data") .. "/site/java/workspace-root/" .. project_name
		-- os.execute("mkdir " .. workspace_dir)

		local defaults = {
			cmd = {
				"java",
				"-Declipse.application=org.eclipse.jdt.ls.core.id1",
				"-Dosgi.bundles.defaultStartLevel=4",
				"-Declipse.product=org.eclipse.jdt.ls.core.product",
				"-Dlog.protocol=true",
				"-Dlog.level=ALL",
				"-javaagent:" .. vim.fn.expand("$MASON/share/jdtls/lombok.jar"),
				"-Xms1g",
				"--add-modules=ALL-SYSTEM",
				"--add-opens",
				"java.base/java.util=ALL-UNNAMED",
				"--add-opens",
				"java.base/java.lang=ALL-UNNAMED",
				"-jar",
				vim.fn.expand("$MASON/share/jdtls/plugins/org.eclipse.equinox.launcher.jar"),
				"-configuration",
				vim.fn.expand("$MASON/share/jdtls/config"),
				"-data",
				workspace_dir,
			},
			root_dir = root_dir,
			settings = {
				java = {
					eclipse = {
						downloadSources = true,
					},
					configuration = {
						updateBuildConfiguration = "interactive",
					},
					maven = {
						downloadSources = true,
					},

					implementationsCodeLens = {
						enabled = true,
					},
					referencesCodeLens = {
						enabled = true,
					},
				},
				signatureHelp = {

					enabled = true,
				},
				completion = {
					favoriteStaticMembers = {
						"org.hamcrest.MatcherAssert.assertThat",
						"org.hamcrest.Matchers.*",
						"org.hamcrest.CoreMatchers.*",
						"org.junit.jupiter.api.Assertions.*",
						"java.util.Objects.requireNonNull",
						"java.util.Objects.requireNonNullElse",
						"org.mockito.Mockito.*",
					},
				},
				sources = {
					organizeImports = {
						starThreshold = 9999,
						staticStarThreshold = 9999,
					},
				},
			},
			init_options = {
				bundles = {
					vim.fn.expand("$MASON/share/java-debug-adapter/com.microsoft.java.debug.plugin.jar"),
					-- unpack remaining bundles
					(table.unpack or unpack)(vim.split(vim.fn.glob("$MASON/share/java-test/*.jar"), "\n", {})),
				},
			},
			handlers = {
				["$/progress"] = function()
					-- disable progress updates.
				end,
			},
			filetypes = { "java" },
			on_attach = function(client, bufnr)
				require("jdtls").setup_dap({ hotcodereplace = "auto" })
				require("astronvim.utils.lsp").on_attach(client, bufnr)
			end,
		}

		-- TODO: add overwrite for on_attach

		-- ensure that table is valid
		if not opts then
			opts = {}
		end

		-- extend the current table with the defaults keeping options in the user opts
		-- this allows users to pass opts through an opts table in community.lua
		opts = vim.tbl_deep_extend("keep", opts, defaults)

		-- send opts to config
		return opts
	end,
}
