local c = require("custom.colors.color")

return {
	highlight_groups = {
		Folded = { fg = c.blue3, bg = c.gray2, blend = 20 },
		FoldColumn = { fg = c.blue3, bg = c.yellow2 },
		CursorLine = { bg = c.blue1, blend = 3 }, -- Cursorline in neotree

		-- For non-current windows
		NormalNC = { bg = c.bg_dark },

		-- Oil directory
		Directory = { fg = c.blue3, bold = true, italic = true },

		-- Telescope
		TelescopeMatching = { fg = c.red2 },

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

		HoltersTitle = { fg = c.purple3 },

		-- Java
		["@lsp.type.class.java"] = { fg = "foam" },
		["@lsp.type.interface.java"] = { link = "@lsp.type.class.java" },
		["@lsp.type.modifier.java"] = { link = "keyword" },
		["@type.qualifier.java"] = { fg = c.purple3 },
	},
}
