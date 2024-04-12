local M = {}

---@param parent Node
---@param absolute_path string
---@param name string
---@param fs_stat uv_fs_t|nil
---@return Node
function M.folder(parent, absolute_path, name, fs_stat)
	local handle = vim.loop.fs_scandir(absolute_path)
	local has_children = handle and vim.loop.fs_scandir_next(handle) ~= nil

	local node = {
		type = "directory",
		absolute_path = absolute_path,
		fs_stat = fs_stat,
		group_next = nil, -- If node is grouped, this points to the next child dir/link node
		has_children = has_children,
		name = name,
		nodes = {},
		open = false,
		parent = parent,
	}
	return node
end

---@param parent Node
---@param absolute_path string
---@param name string
---@param fs_stat uv_fs_t|nil
---@return Node
function M.file(parent, absolute_path, name, fs_stat)
	local ext = string.match(name, ".?[^.]+%.(.*)") or ""

	return {
		type = "file",
		absolute_path = absolute_path,
		executable = false,
		extension = ext,
		fs_stat = fs_stat,
		name = name,
		parent = parent,
	}
end

return M
