local builder = require("custom.filetree.tree-builder")

---@alias Root
---| {absolute_path: string, children: table<Node>}

---@class FileTree
---@field root Root
---@field path string
---@field tree table<string, Node>
local FileTree = {}
FileTree.__index = FileTree

function FileTree:new()
	local _path = vim.fn.getcwd()
	local ft = setmetatable({
		root = { absolute_path = _path, children = {} },
		path = _path,
		tree = {},
	}, self)
	return ft
end

function FileTree:init()
	local handle = vim.loop.fs_scandir(self.path)
	if handle == nil then
		return
	end

	builder.exoloreNode(handle, self, self.root, 1)
end

return FileTree
