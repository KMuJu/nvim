local c = require("custom.colors.color")
return {
	groups = {
		background = c.bg,
		background_nc = c.bg,
		panel = c.bg,
		panel_nc = c.bg,
		border = "highlight_med",
		comment = "muted",
		link = "iris",
		punctuation = "subtle",

		error = "love",
		hint = "iris",
		info = "foam",
		warn = "gold",

		headings = {
			h1 = "iris",
			h2 = "foam",
			h3 = "rose",
			h4 = "gold",
			h5 = "pine",
			h6 = "foam",
		},
	},
	-- or set all headings at once
	-- headings = 'subtle'

	highlight_groups = {
		Folded = { fg = c.blue3, bg = c.gray2, blend = 20 },
		FoldColumn = { fg = c.blue3, bg = c.yellow2 },
		CursorLine = { bg = c.blue1, blend = 3 }, -- Cursorline in neotree

		-- For non-current windows
		NormalNC = { bg = c.bg },

		-- Oil directory
		Directory = { fg = c.blue3, bold = true, italic = true },

		-- Telescope
		TelescopeMatching = { fg = c.red2 },
		ColorColumn = { bg = "rose" },

		-- Blend colours against the "base" background
		StatusLine = { fg = "love", bg = "love", blend = 10 },

		-- By default each group adds to the existing config.
		-- If you only want to set what is written in this config exactly,
		-- you can set the inherit option:
		Search = { bg = "gold", inherit = false },
		-- NormalNC = { bg = bg_light },

		-- markdownH1 = { fg = red2 },      -- markdown header
		["@markup.list.unchecked.markdown"] = { fg = c.red2, bold = true },
		["@markup.list.checked.markdown"] = { fg = c.gray1, bold = true, blend = 30 },
		["@markup.list"] = { bg = c.aqua1, blend = 10, bold = true },
		["LspReferenceWrite"] = { bg = c.gray1, blend = 10 },
		["LspReferenceRead"] = { bg = c.gray2, blend = 10 },
		["LspReferenceText"] = { bg = c.gray2, blend = 10 },
		["Visual"] = { bg = c.visual, blend = 45 },
		DiffDelete = { bg = c.yellow3 },
		DiffAdd = { bg = c.green3 },
		KMuJuTitle = { fg = c.purple3 },

		-- Java
		["@lsp.type.class.java"] = { fg = "foam" },
		["@lsp.type.interface.java"] = { link = "@lsp.type.class.java" },
		["@lsp.type.modifier.java"] = { link = "keyword" },
		["@type.qualifier.java"] = { fg = c.purple3 },

		-- Rust
		["@lsp.type.selfKeyword.rust"] = { link = "@variable.builtin" },
	},
}
