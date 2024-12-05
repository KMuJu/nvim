local M = {}

---@param config OutlineConfig
---@return number, number
function M.split(config)
	local buf = vim.api.nvim_create_buf(false, true)
	vim.api.nvim_set_option_value("bufhidden", "wipe", { buf = buf })
	vim.api.nvim_set_option_value("buftype", "nofile", { buf = buf })
	vim.api.nvim_set_option_value("filetype", config.name, { buf = buf })
	vim.api.nvim_set_option_value("swapfile", false, { buf = buf })
	vim.api.nvim_buf_set_name(buf, config.name)

	local win = vim.api.nvim_open_win(buf, true, {
		vertical = config.vertical,
		split = config.split,
		width = config.width,
	})
	return buf, win
end

---@param win number
function M.close(win)
	vim.api.nvim_win_close(win, true)
end

return M
