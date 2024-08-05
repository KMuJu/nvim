local rose_pine = require("core.colors.rose-pine")

local function get_if_available(colors)
	local lua_ok, colorscheme = pcall(require, colors)
	if lua_ok then
		return colorscheme
	end

	local vim_ok, colorschemeV = pcall(vim.cmd.colorscheme, colors)
	if vim_ok then
		return colorschemeV
	end
	return rose_pine
end

local custom = get_if_available("core.colors.rose_pine")
print("ABABABABABABAB")
return custom
