

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
local default = get_if_available("core.colors.customDefault")

local M = {}
M.all = {
    vim.tbl_deep_extend("keep", rose_pine, default),
    vim.tbl_deep_extend("keep", dark, default),
    vim.tbl_deep_extend("keep", gruvBox, default),
}

M.index = 1
M.custom = M.all[M.index]

M.switch = function ()
    M.index = (M.index % #M.all) + 1
    M.custom = M.all[M.index]
end

return M

