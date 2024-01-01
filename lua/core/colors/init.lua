

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

local gruvBox = get_if_available("core.colors.customGruvbox")
local dark = get_if_available("core.colors.customDark")
-- local custom = get_if_available("gruvbox")

local M = {}
M.all = {
    gruvBox,
    dark,
}

M.index = 2
M.custom = M.all[M.index]

M.switch = function ()
    M.index = (M.index % #M.all) + 1
    M.custom = M.all[M.index]
end

return M

