local M = {}

local name = "Outline"

function M.split()
	local buf = vim.api.nvim_create_buf(false, true)
	vim.api.nvim_set_option_value("bufhidden", "wipe", { buf = buf })
	vim.api.nvim_set_option_value("buftype", "nofile", { buf = buf })
	vim.api.nvim_set_option_value("filetype", name, { buf = buf })
	vim.api.nvim_set_option_value("swapfile", false, { buf = buf })

	-- TODO: use vim.api.nvim_open_win
	vim.cmd("aboveleft vsplit")
	local win = vim.api.nvim_get_current_win()
	vim.api.nvim_win_set_width(win, 45)
	vim.api.nvim_set_current_buf(buf)
	return buf, win
end

function M.close(win)
	vim.api.nvim_win_close(win, true)
end

return M
