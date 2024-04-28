return {
	"nvim-treesitter/nvim-treesitter",
	build = function()
		pcall(require("nvim-treesitter.install").update({ with_sync = true }))
	end,
	dependencies = {
		"nvim-treesitter/nvim-treesitter-textobjects",
	},

	config = function()
		require("nvim-treesitter.configs").setup({
			-- Add languages to be installed here that you want installed for treesitter
			ensure_installed = {
				"svelte",
				"typescript",
				"javascript",
				"html",
				"css",
				"c",
				"cpp",
				"go",
				"lua",
				"python",
				"rust",
				"vim",
			},

			rainbow = {
				enable = true,
				-- disable = { "jsx", "cpp" }, list of languages you want to disable the plugin for
				disable = { "html" },
				extended_mode = false, -- Also highlight non-bracket delimiters like html tags, boolean or table: lang -> boolean
				colors = {
					"#C9C300",
					"#AF48AD",
					"#458588",
					-- "#d79921",
					-- "#F199D4",
				},
				termcolors = {
					"Green",
					"Yellow",
					"Blue",
					"Magenta",
					"Cyan",
					"White",
					"Red",
				},
				max_file_lines = nil, -- Do not enable for files with more than n lines, int
			},

			sync_install = false,
			modules = {},
			ignore_install = { "" },
			auto_install = true,
			highlight = { enable = true, disable = { "latex" } },
			indent = { enable = true, disable = { "python" } },
			incremental_selection = {
				enable = false,
				keymaps = {
					init_selection = "<c-space>",
					node_incremental = "<c-space>",
					scope_incremental = "<c-s>",
					node_decremental = "<c-backspace>",
				},
			},
			textobjects = {
				select = {
					enable = true,
					lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
					keymaps = {
						-- You can use the capture groups defined in textobjects.scm
						["aa"] = "@parameter.outer",
						["ia"] = "@parameter.inner",
						["af"] = "@function.outer",
						["if"] = "@function.inner",
						["ac"] = "@class.outer",
						["ic"] = "@class.inner",
					},
				},
				move = {
					enable = true,
					set_jumps = true, -- whether to set jumps in the jumplist
					goto_next_start = {
						["]m"] = "@function.outer",
						["]]"] = "@class.outer",
					},
					goto_next_end = {
						["]M"] = "@function.outer",
						["]["] = "@class.outer",
					},
					goto_previous_start = {
						["[m"] = "@function.outer",
						["[["] = "@class.outer",
					},
					goto_previous_end = {
						["[M"] = "@function.outer",
						["[]"] = "@class.outer",
					},
				},
			},
		})
	end,
}
