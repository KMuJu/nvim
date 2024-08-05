local dark_brown--[[              ]] = "#212121"
local dark_brown_light--[[        ]] = "#40352C"
local clay--[[                    ]] = "#A85147"
local orange--[[                  ]] = "#fe933a"
local orange_dark--[[             ]] = "#F98220"
local pale_yellow--[[             ]] = "#ECBC62"
local dark_yellow--[[             ]] = "#DCA148"
local light_orange--[[            ]] = "#F08152"
local muted_brown--[[             ]] = "#2C2927"
local border--[[                  ]] = "#161208"
local gray--[[                    ]] = "#2F3A37"
local gold--[[                    ]] = "#f6c177"
local light_blue--[[              ]] = "#0BEBE5"
local light_blue2--[[             ]] = "#7AD3E2"
local c--[[                       ]] = "#000000"
local light_clay--[[              ]] = "#E18775"
local pale_yellow2--[[            ]] = "#EDCC8E"
local yellow--[[                  ]] = "#F7F06F"

-- GRUVBOX
local bg--[[          ]] = "#282828"
local fg--[[          ]] = "#ebdbb2"
local red1--[[        ]] = "#cc241d"
local red2--[[        ]] = "#fb4934"
local green1--[[      ]] = "#98971a"
local green2--[[      ]] = "#b8bb26"
local yellow1--[[     ]] = "#d79921"
local yellow2--[[     ]] = "#fabd2f"
local blue1--[[       ]] = "#458588"
local blue2--[[       ]] = "#83a598"
local purple1--[[     ]] = "#b16286"
local purple2--[[     ]] = "#d3869b"
local aqua1--[[       ]] = "#689d6a"
local aqua2--[[       ]] = "#8ec07c"
local gray1--[[       ]] = "#a89984"
local gray2--[[       ]] = "#928374"

return {
	groups = {
		background = dark_brown,
		background_nc = dark_brown_light,
		panel = dark_brown_light,
		panel_nc = dark_brown_light,
		border = border,
		comment = "muted",
		link = orange,
		punctuation = pale_yellow,

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
		ColorColumn = { bg = clay },

		-- Blend colours against the "base" background
		CursorLine = { bg = gray, blend = 100 },
		StatusLine = { fg = pale_yellow, bg = dark_yellow, blend = 10 },

		-- By default each group adds to the existing config.
		-- If you only want to set what is written in this config exactly,
		-- you can set the inherit option:
		Search = { bg = "gold", inherit = false },
		Function = { fg = pale_yellow },
		-- local and such
		Statement = { fg = light_orange },
		Keyword = { fg = light_orange },

		DiagnosticStatusLineHint = { fg = "love" },
		Type = { fg = gold },
		["@field"] = { fg = light_blue2 },
		["@parameter"] = { fg = light_blue2, italic = true },
	},
}
