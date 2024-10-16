-- GRUVBOX
local bg--[[          ]] = "#282828"
local bg0_h--[[       ]] = "#1d2021"
local bg_dark--[[     ]] = "#101112"
local fg--[[          ]] = "#ebdbb2"
local red1--[[        ]] = "#cc241d"
local red2--[[        ]] = "#fb4934"
local red3--[[        ]] = "#e83d27"
local green1--[[      ]] = "#98971a"
local green2--[[      ]] = "#b8bb26"
local green3--[[      ]] = "#6cb310"
local yellow1--[[     ]] = "#d79921"
local yellow2--[[     ]] = "#fabd2f"
local yellow3--[[     ]] = "#edc44a"
local yellow4--[[     ]] = "#e8d497"
local blue1--[[       ]] = "#458588"
local blue2--[[       ]] = "#83a598"
local blue3--[[       ]] = "#91b6f2"
local purple1--[[     ]] = "#b16286"
local purple2--[[     ]] = "#d3869b"
local purple3--[[     ]] = "#e38dfc"
local aqua1--[[       ]] = "#689d6a"
local aqua2--[[       ]] = "#8ec07c"
local gray1--[[       ]] = "#a89984"
local gray2--[[       ]] = "#928374"

-- local visual    = "#8395a3"
local visual--[[      ]] = "#a39d83"

local custom = {
	groups = {
		background = bg_dark,
		background_nc = bg_dark,
		panel = bg_dark,
		panel_nc = bg_dark,
		border = fg,
		comment = "muted",
		link = red2,
		punctuation = gray1,

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
		ColorColumn = { bg = aqua1 },

		-- Blend colours against the "base" background
		CursorLine = { bg = blue1, blend = 40 }, -- Cursorline in neotree
		StatusLine = { fg = yellow1, bg = yellow2, blend = 10 },

		-- By default each group adds to the existing config.
		-- If you only want to set what is written in this config exactly,
		-- you can set the inherit option:
		Search = { bg = "gold", inherit = false },
		Function = { fg = blue3 },
		-- local and such
		Statement = { fg = red1 },
		Keyword = { fg = purple3 },
		DiagnosticStatusLineHint = { fg = "love" },

		-- For non-current windows
		NormalNC = { bg = bg_dark },

		-- Oil directory
		Directory = { fg = blue3, bold = true, italic = true },

		-- Telescope
		TelescopeMatching = { fg = red2 },

		Type = { fg = red2 },

		Variable = { fg = blue1 },
		Float_border = { fg = red1, bg = yellow1 },
		["@field"] = { fg = "foam" },
		["@property"] = { fg = "foam" },
		["@parameter"] = { fg = fg, italic = true },
		["String"] = { fg = yellow4, bold = false },
		["DashboardHeader"] = { fg = red2 },
		["LspReferenceWrite"] = { bg = gray1, blend = 15 },
		["LspReferenceRead"] = { bg = gray2, blend = 15 },
		["Visual"] = { bg = visual, blend = 45 },
	},
}

return custom
