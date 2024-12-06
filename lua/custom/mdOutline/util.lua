local M = {}

local function check_size(w, h, c_w, c_h)
	return w - c_w > (h - c_h) * 2
end

---@param config OutlineConfig
---@return number, number
function M.split(config)
	config = config or {}
	vim.tbl_extend("keep", config, {
		vertical = true,
		check_size = check_size,
	})
	local buf = vim.api.nvim_create_buf(false, true)
	vim.api.nvim_set_option_value("bufhidden", "wipe", { buf = buf })
	vim.api.nvim_set_option_value("buftype", "nofile", { buf = buf })
	vim.api.nvim_set_option_value("filetype", config.name, { buf = buf })
	vim.api.nvim_set_option_value("swapfile", false, { buf = buf })
	vim.api.nvim_buf_set_name(buf, config.name)

	-- local orig_win = vim.api.nvim_get_current_win()
	local w = vim.api.nvim_win_get_width(0)
	local h = vim.api.nvim_win_get_height(0)
	local split_cmd
	local size
	if
		config.vertical == true
		or config.vertical == "auto" and config.check_size(w, h, config.width, config.height)
	then
		split_cmd = "aboveleft vsplit"
		size = { width = config.width }
	else
		split_cmd = "belowright split"
		size = { height = config.height }
	end

	vim.cmd(split_cmd)
	local win = vim.api.nvim_get_current_win()
	vim.api.nvim_win_set_config(win, size) -- set the size of the window
	vim.api.nvim_win_set_buf(win, buf)
	return buf, win
end

---@param win number
function M.close(win)
	vim.api.nvim_win_close(win, true)
end

return M
