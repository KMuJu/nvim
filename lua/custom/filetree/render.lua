local constants = require("custom.filetree.const")

local M = {}
local tree = require("custom.filetree.tree-builder")

---@param parent Node
local function get_visible_names(parent)
	local names = {}
	for _, node in ipairs(parent.children) do
		table.insert(names, node.name)
	end
	return names
end

---@return integer, integer
local function create_buf()
	local win = vim.api.nvim_get_current_win()
	local buf = vim.api.nvim_create_buf(false, true)

	vim.api.nvim_set_option_value("bufhidden", "wipe", { buf = buf })
	vim.api.nvim_set_option_value("buftype", "nofile", { buf = buf })
	vim.api.nvim_set_option_value("filetype", constants.name, { buf = buf })
	vim.api.nvim_set_option_value("swapfile", false, { buf = buf })

	vim.api.nvim_win_set_buf(win, buf)

	vim.cmd("vsplit")

	return buf, -1
end

---@param root Root
M.draw = function(root)
	local names = get_visible_names(root)
	print(vim.inspect(names))
	local buf, _ = create_buf()

	vim.api.nvim_buf_set_lines(buf, 0, 0, true, names)
end

local path = vim.fn.getcwd()
local handle = vim.loop.fs_scandir(path)
if handle == nil then
	return
end

---@alias Root
---| {absolute_path: string, children: table<Node>}

---@type Root
local root = { absolute_path = vim.fn.getcwd(), children = {} }
tree.exoloreNode(handle, path, root)
M.draw(root)

return M
