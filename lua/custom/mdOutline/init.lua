local util = require("custom.mdOutline.util")

local config = require("custom.mdOutline.config")

local highlight_id = vim.api.nvim_create_namespace("markdownOutline")

local function get_root(bufnr)
	local parser = vim.treesitter.get_parser(bufnr, "markdown", {})
	local tree = parser:parse()[1]
	return tree:root()
end

local headerQuery = vim.treesitter.query.parse(
	"markdown",
	[[
(section) @string
]]
)

---@param node TSNode
---@param bufnr number
---@return string, number
local function get_text(node, bufnr)
	local line = vim.treesitter.get_node_text(node, bufnr)
	line = string.match(line, "([^\n]*)")
	local level = 0
	for i = 1, #line do
		local c = line:sub(i, i)
		if c ~= "#" then
			break
		end
		level = level + 1
	end
	return string.gsub(line, "^#* ", ""), 7 - level
end

---@class Header
---@field node TSNode
---@field text string
---@field level number
---@field row number
---@field children Header[]
---@field open boolean

---@return Header[]
local function get_headers(bufnr)
	local root = get_root(bufnr)

	local headers = {}
	local all_headers = {}

	for _, node in headerQuery:iter_captures(root, bufnr, 0, -1) do
		local range = { node:range() }
		local row = range[1]
		local text, level = get_text(node, bufnr)
		if level == 7 then -- Section might not be a header
			goto continue
		end
		---@type Header
		local h = {
			node = node,
			text = text,
			level = level,
			row = row + 1,
			children = {},
			open = false,
		}

		local child = false
		for i = #all_headers, 1, -1 do -- Latest addition will most likely be the parent
			local hd = all_headers[i]
			-- Header cannot be children of smaller headers
			if hd.level > level and vim.treesitter.is_ancestor(hd.node, h.node) then
				table.insert(hd.children, h)
				child = true
				break
			end
		end
		if not child then
			table.insert(headers, h)
		end

		table.insert(all_headers, h)
		::continue::
	end

	return headers
end

---@param header Header
---@return string
local function get_arrow(header)
	local a = " "
	if #header.children ~= 0 then
		a = header.open and "▼" or "▶"
	end
	return a
end

---Recursively finds the lines of children and add them to the lines table
---
--- TODO:  |
---        V
--- Might be better to simply pass in the lines table,
--- and insert into that instead of creating a new table for each child and moving into the parent
---
---@param header Header
---@param shown Header[] table to insert each children, because they are shown
---@return string[]
local function get_header_lines(header, shown)
	local lines = {}
	for _, h in ipairs(header.children) do
		table.insert(lines, string.rep(" ", (7 - h.level - 1) * 2) .. get_arrow(h) .. " " .. h.text)
		table.insert(shown, h)
		if h.open then
			local childLines = get_header_lines(h, shown)
			table.move(childLines, 1, #childLines, #lines + 1, lines) -- Adds the lines from the children into lines
		end
	end
	return lines
end

--- Sets lines and extmarks of buffer
---@param buf number Buffer that will contain the headers
---@param headers Header[] All headers in a forest-like structure
---@param title string Shown at the top of the buffer
---@return Header[] Shown Table of shown headers in correct order
local function render_headers(buf, headers, title)
	local lines = { title }
	local shown = {}
	for _, h in ipairs(headers) do -- the same as get_header_lines but loops the top layer instead of children
		table.insert(lines, get_arrow(h) .. " " .. h.text)
		table.insert(shown, h)
		if h.open then
			local childLines = get_header_lines(h, shown)
			table.move(childLines, 1, #childLines, #lines + 1, lines)
		end
	end
	vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)
	for i, h in ipairs(shown) do -- shown is the table of shown headers, each element on one line
		-- sets the extmark at line i instead of i-1 because of the title
		vim.api.nvim_buf_set_extmark(buf, highlight_id, i, 0, {
			end_row = i + 1,
			hl_group = config.highlights[h.level],
		})
	end
	return shown
end

---@param win number
---@param shown Header[]
---@param open boolean
local function open_close_line(win, shown, open)
	local row, _ = unpack(vim.api.nvim_win_get_cursor(win))
	row = row - 1
	if row == 0 then
		return
	end
	shown[row].open = open
end

---@param buf number
---@return number
local function find_win(buf)
	local wins = vim.api.nvim_list_wins()
	for _, w in ipairs(wins) do
		if vim.api.nvim_win_get_buf(w) == buf then
			return w
		end
	end
	return -1
end

---@param buf number
local function focus_window(buf)
	local win = find_win(buf)
	if win == -1 then
		return
	end
	vim.api.nvim_set_current_win(win)
end

local M = {
	opened = false,
}

function M.open()
	if M.opened and vim.api.nvim_buf_get_name(0) == M.bufname then
		focus_window(M.buf)
		return
	end

	M.opened = true
	local orig_buf = vim.api.nvim_get_current_buf()
	local headers = get_headers(0)
	---@type Header
	---@diagnostic disable-next-line: missing-fields
	local bottom = {
		text = "END",
		level = 7,
		row = #vim.api.nvim_buf_get_lines(orig_buf, 0, -1, true),
		open = false,
		children = {},
	}
	table.insert(headers, bottom)
	local buf, win = util.split(config)
	local bufname = vim.api.nvim_buf_get_name(orig_buf)
	local filename = vim.fn.fnamemodify(bufname, ":t")
	local shown = render_headers(buf, headers, filename)
	M.buf = buf
	M.bufname = bufname

	vim.keymap.set("n", "l", function()
		open_close_line(win, shown, true) -- set header below cursor to be closed
		shown = render_headers(buf, headers, filename) -- rerender the headers
		-- might be able to only rerender the closed lines
		-- ie. remove or add the lines of the header under the cursor
	end, { buffer = true })

	vim.keymap.set("n", "h", function() -- same as l keymap, but closes the header
		open_close_line(win, shown, false)
		shown = render_headers(buf, headers, filename)
	end, { buffer = true })

	vim.keymap.set("n", "<cr>", function()
		local row, _ = unpack(vim.api.nvim_win_get_cursor(0))
		row = row - 1
		local line = row ~= 0 and tostring(shown[row].row) or "1"
		local w = find_win(orig_buf)
		if w == -1 then -- Did not find window
			vim.cmd("wincmd l") -- goes to the window to the right
			vim.api.nvim_set_current_buf(orig_buf) -- changes buffer to original, in case it was changed
		else
			vim.api.nvim_set_current_win(w)
		end
		vim.cmd(line) -- goes to the line of the header
		vim.cmd("normal! zz") -- centers the cursor
	end, { buffer = true })

	vim.keymap.set("n", "q", function()
		util.close(win)
		M.opened = false
		M.buf = nil
	end, { buffer = true })
end
return M
