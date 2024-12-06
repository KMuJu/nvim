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

	local split
	local size = {}
	if config.vertical == "auto" then
		local orig_win = vim.api.nvim_get_current_win()
		local w = vim.api.nvim_win_get_width(orig_win)
		local h = vim.api.nvim_win_get_height(orig_win)
		if w - config.width > (h - config.height) * 2 then
			split = "aboveleft vsplit"
			size = { width = config.width }
		else
			split = "belowright split"
			size = { height = config.height }
		end
	elseif config.vertical == true then
		split = "aboveleft vsplit"
		size = { width = config.width }
	else
		split = "belowright split"
		size = { height = config.height }
	end

	vim.cmd(split)
	local win = vim.api.nvim_get_current_win()
	vim.api.nvim_win_set_config(win, size)
	vim.api.nvim_win_set_buf(win, buf)
	return buf, win
end

---@param win number
function M.close(win)
	vim.api.nvim_win_close(win, true)
end

return M
