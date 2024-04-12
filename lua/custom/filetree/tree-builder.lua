local util = require("custom.filetree.utils")
local nodeBuilder = require("custom.filetree.node-builder")

local M = {}

---@param handle uv_fs_t
---@param cwd string
---@param parent Node
local function exoloreNode(handle, cwd, parent)
	-- print(cwd)

	while true do
		local name, type = vim.loop.fs_scandir_next(handle)
		if not name then
			break
		end
		local path = util.path_join({ cwd, name })
		-- print("B")
		if util.ishidden(name) then
			goto continue
		end

		local stat = vim.loop.fs_stat(path)

		local node
		if type == "directory" then
			node = nodeBuilder.folder(parent, path, name, stat)
		elseif type == "file" then
			node = nodeBuilder.file(parent, path, name, stat)
		end
		if node ~= nil then
			table.insert(parent.children, node)
		end

		::continue::
	end
end

M.exoloreNode = exoloreNode

return M
