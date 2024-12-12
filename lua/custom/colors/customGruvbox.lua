-- GRUVBOX
local c = require("custom.colors.color")

local visual = "#a39d83"

local custom = {
	groups = {
		background = c.bg0_h,
		background_nc = c.bg0_h,
		panel = c.bg0_h,
		panel_nc = c.bg0_h,
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
		Keyword = { fg = c.red2 },

		DiagnosticStatusLineHint = { fg = "love" },
		Type = { fg = c.green2 },
		Variable = { fg = c.blue1 },
		["@field"] = { fg = "foam" },
		["@property"] = { fg = "foam" },
		["@parameter"] = { fg = c.fg, italic = true },
		["String"] = { fg = c.green2, bold = false },
		["DashboardHeader"] = { fg = c.red2 },
		["Visual"] = { bg = c.visual, blend = 45 },
	},
}

return custom
