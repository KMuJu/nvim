---@class OutlineConfig
---@field vertical boolean|"auto"
---@field split "left"|"right"|"above"|"below"
---@field width number
---@field height number
---@field name string
---@field highlights string[]
---@field check_size function|nil

---@type OutlineConfig
return {
	vertical = true,
	split = "left",
	width = 45,
	height = 16,
	name = "mdOutline",
	highlights = {
		[6] = "@markup.heading.1.markdown",
		[5] = "@markup.heading.2.markdown",
		[4] = "@markup.heading.3.markdown",
		[3] = "@markup.heading.4.markdown",
		[2] = "@markup.heading.5.markdown",
		[1] = "@markup.heading.6.markdown",
	},
}
