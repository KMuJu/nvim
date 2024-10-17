local utils = require("custom.select.utils")

local M = {}

---@param items any[]
---@param opts table
---@param on_choice fun(item: any?, idx: integer?)
function M.select(items, opts, on_choice)
	local lines = {}
	local maxwidth = 0
    local winWidth = vim.api.nvim_win_get_width(0)
    local winHeight = vim.api.nvim_win_get_height(0)
	-- Create the lines from items with format_item and gets max length
	for _, item in ipairs(items) do
		local str = opts.format_item(item)
		table.insert(lines, str)
		if maxwidth < string.len(str) then
			maxwidth = string.len(str)
		end
	end
    table.insert(lines, "")

    maxwidth = math.min(maxwidth, winWidth -10)
    local maxheight = math.min(#lines, winHeight -10)

	local buf, win = utils.create_window(true, {
		win_options = {
			number = true,
			relativenumber = false,
			winhl = "Normal:NormalFloatNC",
		},
		width = maxwidth,
		height = #lines,
		title = opts.prompt or "Select:",
	})

	vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)

	-- Adds the number keymap to each item
	for index, _ in pairs(items) do
		utils.add_key_map(index, function()
			on_choice(items[index], index)
			utils.closeWindow(buf, win)
		end, buf)
	end

	-- Every key that will close the window without a selection
	for _, key in pairs({ "q", "<ESC>", "<C-c>" }) do
		vim.keymap.set("n", key, function()
			utils.closeWindow(buf, win)
		end)
	end

	-- Every key that will select current line
	for _, key in pairs({ "<CR>", "<C-space>" }) do
		vim.keymap.set("n", key, function()
			local index, _ = unpack(vim.api.nvim_win_get_cursor(0))
			on_choice(items[index], index)
			utils.closeWindow(buf, win)
		end)
	end

	vim.api.nvim_create_autocmd({ "BufLeave", "ModeChanged" }, {
		buffer = buf,
		callback = function()
			utils.closeWindow(buf, win)
		end,
	})
end

return M
