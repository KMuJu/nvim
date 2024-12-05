---@class OutlineConfig
---@field vertical boolean
---@field split "left"|"right"|"above"|"below"
---@field width number
---@field name string
---@field highlights string[]

---@type OutlineConfig
return {
	vertical = true,
	split = "left",
	width = 45,
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
