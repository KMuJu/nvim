local config = require("custom.select.config")

local M = {}

function M.create_window(enter, opts)
	local win_options = opts.win_options or {}
	opts.win_options = nil
	local buf_id = vim.api.nvim_create_buf(false, true)
	local win_config = config.createConfig(opts)
	local win_id = vim.api.nvim_open_win(buf_id, enter, win_config)
	print(vim.inspect(win_config))

	for opt, val in pairs(win_options) do
		vim.api.nvim_set_option_value(opt, val, { win = win_id })
	end

	return buf_id, win_id
end

function M.closeWindow(buf_id, win_id)
	if win_id ~= nil and vim.api.nvim_win_is_valid(win_id) then
		vim.api.nvim_win_close(win_id, true)
	end
	if buf_id ~= nil and vim.api.nvim_buf_is_valid(buf_id) then
		vim.api.nvim_buf_delete(buf_id, { force = true })
	end
end

function M.add_key_map(key, func, buf)
	print(buf)
	vim.keymap.set("n", tostring(key), func, { buffer = buf })
end

return M
