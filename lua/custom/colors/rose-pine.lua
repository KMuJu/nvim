local c = require("custom.colors.color")
local bg = c.bg
local bg_light = c.bg1
return {
	groups = {
		background = bg,
		background_nc = bg,
		panel = bg,
		panel_nc = bg,
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
		ColorColumn = { bg = "rose" },

		-- Blend colours against the "base" background
		StatusLine = { fg = "love", bg = "love", blend = 10 },

		-- By default each group adds to the existing config.
		-- If you only want to set what is written in this config exactly,
		-- you can set the inherit option:
		Search = { bg = "gold", inherit = false },
		NormalNC = { bg = bg_light },
	},
}
