-- GRUVBOX
local c = require("custom.colors.color")

local custom = {
	groups = {
		background = c.bg,
		background_nc = c.bg,
		panel = c.bg,
		panel_nc = c.bg,
		border = c.fg,
		comment = "muted",
		link = c.red2,
		punctuation = c.gray1,

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

	highlight_groups = {
		ColorColumn = { bg = c.aqua1 },

		-- Blend colours against the "base" background
		CursorLine = { bg = c.blue1, blend = 40 }, -- Cursorline in neotree
		StatusLine = { fg = c.yellow1, bg = c.yellow2, blend = 10 },

		-- By default each group adds to the existing config.
		-- If you only want to set what is written in this config exactly,
		-- you can set the inherit option:
		Search = { bg = "gold", inherit = false },
		Function = { fg = c.blue3 },
		-- local and such
		Statement = { fg = c.red1 },
		Keyword = { fg = c.purple3 },
		DiagnosticStatusLineHint = { fg = "love" },

		-- For non-current windows
		NormalNC = { bg = c.bg },

		-- Oil directory
		Directory = { fg = c.blue3, bold = true, italic = true },

		-- Telescope
		TelescopeMatching = { fg = c.red2 },

		Type = { fg = c.red2 },

		Variable = { fg = c.blue1 },
		Float_border = { fg = c.red1, bg = c.yellow1 },
		["@field"] = { fg = "foam" },
		["@property"] = { fg = "foam" },
		["@parameter"] = { fg = c.fg, italic = true },
		["String"] = { fg = c.yellow4, bold = false },
		["DashboardHeader"] = { fg = c.red2 },
		["LspReferenceWrite"] = { bg = c.gray1, blend = 15 },
		["LspReferenceRead"] = { bg = c.gray2, blend = 15 },
		["Visual"] = { bg = c.visual, blend = 45 },
	},
}

return custom
