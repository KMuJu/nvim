local M = {}

local function min(a, b)
	if a < b then
		return a
	else
		return b
	end
end
local function max(a, b)
	if a > b then
		return a
	else
		return b
	end
end

function M.createConfig(opts)
	local min_width = math.floor(vim.o.columns * 0.3)
	local min_height = 1
	local width = max(min_width, opts.width)
	local height = max(min_height, opts.height)
	opts = opts or {}
	-- removes the width and height field to overwrite it when extending
	opts.width = nil
	opts.height = nil
	local config = vim.tbl_deep_extend("keep", opts, {
		relative = "editor",
		anchor = "NW",
		width = width,
		height = height,
		border = "rounded",
		noautocmd = true,
		col = (vim.o.columns / 2) - (width / 2),
		row = (vim.o.lines / 2) - (height / 2),
		title_pos = "center",
	})
	return config
end

return M
