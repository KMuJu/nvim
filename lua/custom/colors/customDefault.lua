-- GRUVBOX
local bg--[[       ]] = "#282828"
local bg0_h--[[    ]] = "#1d2021"
local bg_dark--[[  ]] = "#101112"
local fg--[[       ]] = "#ebdbb2"
local red1--[[     ]] = "#cc241d"
local red2--[[     ]] = "#fb4934"
local red3--[[     ]] = "#e83d27"
local green1--[[   ]] = "#98971a"
local green2--[[   ]] = "#b8bb26"
local green3--[[   ]] = "#6cb310"
local yellow1--[[  ]] = "#d79921"
local yellow2--[[  ]] = "#fabd2f"
local yellow3--[[  ]] = "#edc44a"
local yellow4--[[  ]] = "#e8d497"
local blue1--[[    ]] = "#458588"
local blue2--[[    ]] = "#83a598"
local blue3--[[    ]] = "#91b6f2"
local purple1--[[  ]] = "#b16286"
local purple2--[[  ]] = "#d3869b"
local purple3--[[  ]] = "#e38dfc"
local aqua1--[[    ]] = "#689d6a"
local aqua2--[[    ]] = "#8ec07c"
local gray1--[[    ]] = "#a89984"
local gray2--[[    ]] = "#928374"

local visual--[[   ]] = "#a89f88"

return {
	highlight_groups = {
		Folded = { fg = aqua2, bg = gray2, blend = 20 },
		FoldColumn = { fg = aqua2, bg = yellow2 },
		CursorLine = { bg = blue1, blend = 3 }, -- Cursorline in neotree

		-- For non-current windows
		NormalNC = { bg = bg_dark },

		-- Oil directory
		Directory = { fg = blue3, bold = true, italic = true },

		-- Telescope
		TelescopeMatching = { fg = red2 },

		-- markdownH1 = { fg = red2 },      -- markdown header
		["@markup.list.unchecked.markdown"] = { fg = red2, bold = true },
		["@markup.list.checked.markdown"] = { fg = gray1, bold = true, blend = 30 },
		["@type.qualifier.java"] = { fg = purple3 },
		["LspReferenceWrite"] = { bg = gray1, blend = 10 },
		["LspReferenceRead"] = { bg = gray2, blend = 10 },
		["LspReferenceText"] = { bg = gray2, blend = 10 },
		["Visual"] = { bg = visual, blend = 45 },
		DiffDelete = { bg = yellow3 },
		DiffAdd = { bg = green3 },

		HoltersTitle = { fg = purple3 },
	},
}
