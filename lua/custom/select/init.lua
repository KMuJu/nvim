local utils = require("custom.select.utils")

local M = {}

function M.select(items, opts, on_choice)
	local lines = {}
	local maxwidth = 0
	for _, item in ipairs(items) do
		local str = opts.format_item(item)
		table.insert(lines, str)
		if maxwidth < string.len(str) then
			maxwidth = string.len(str)
		end
	end
	local buf, win = utils.create_window(true, {
		win_options = {
			number = true,
			relativenumber = false,
			winhl = "Normal:NormalFloatNC",
		},
		width = maxwidth,
		height = #items,
	})

	vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)

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

	vim.keymap.set("n", "<CR>", function()
		local index, _ = unpack(vim.api.nvim_win_get_cursor(0))
		on_choice(items[index], index)
		utils.closeWindow(buf, win)
	end)

	vim.api.nvim_create_autocmd({ "BufLeave", "ModeChanged" }, {
		buffer = buf,
		callback = function()
			utils.closeWindow(buf, win)
		end,
	})
end

-- M.select({ "a", "bbb", "cc" }, {}, function()
-- 	print("on_choice")
-- end)

return M
