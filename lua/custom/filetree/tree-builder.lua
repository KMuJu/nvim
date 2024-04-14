local util = require("custom.filetree.utils")
local nodeBuilder = require("custom.filetree.node-builder")

local M = {}

---@param handle uv_fs_t
---@param tree FileTree
---@param parent Node
function M.exoloreNode(handle, tree, parent, depth)
	-- print(cwd)
	if depth <= 0 then
		return
	end

	while true do
		local name, type = vim.loop.fs_scandir_next(handle)
		if not name then
			break
		end
		local path = util.path_join({ tree.path, name })
		-- print("B")
		if util.ishidden(name) then
			goto continue
		end

		local stat = vim.loop.fs_stat(path)

		local node
		local index = name
		if type == "directory" then
			node = nodeBuilder.folder(parent, path, name, stat)
			index = index .. "/"
		elseif type == "file" then
			node = nodeBuilder.file(parent, path, name, stat)
		end
		if node ~= nil then
			tree.tree[index] = node
			table.insert(parent.children, node)
		end

		::continue::
	end

	-- TODO: To preview directories as well
	--
	-- for _, node in ipairs(parent.children) do
	-- 	print(node.absolute_path)
	-- 	if node.type == "directory" then
	-- 		local path = node.absolute_path
	-- 		local handle = vim.loop.fs_scandir(path)
	-- 		if handle == nil then
	-- 			return
	-- 		end
	-- 		M.exoloreNode(handle, path, node, depth - 1)
	-- 	end
	-- end
end

return M
