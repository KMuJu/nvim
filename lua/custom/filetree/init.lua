-- TODO: Add fimple filetree selector with preview of file
local render = require("custom.filetree.render")
local util = require("custom.filetree.utils")
local tree = require("custom.filetree.tree"):new()
tree:init()
---@type Previewer
local previewer = require("custom.filetree.preview"):new()

local M = {}

local function on_cursor_move(buf)
	local row, _ = unpack(vim.api.nvim_win_get_cursor(0))
	local line = unpack(vim.api.nvim_buf_get_lines(buf, row - 1, row, true))
	line = string.sub(line, 5, #line)
	print(row)
	print("- ", line)
	-- print(tree.tree[line].absolute_path)
	previewer:preview(tree.tree[line].absolute_path)
end

function M.setup(opts)
	M.opts = opts or {}
end

function M.open()
	local buf = render.draw(tree)
	util.lock_buf(buf)
	vim.keymap.set("n", "<cr>", function()
		print("ENTER FILE")
	end, { buffer = true })
	previewer:init({})
	local win = previewer.win

	vim.api.nvim_create_autocmd("BufWinLeave", {
		once = true,
		buffer = buf,
		callback = function(ev)
			vim.api.nvim_win_close(win, false)
		end,
	})

	vim.api.nvim_create_autocmd("CursorMoved", {
		buffer = buf,
		callback = function(ev)
			on_cursor_move(buf)
		end,
	})
	-- Autocmd CursorMoved
end

return M
