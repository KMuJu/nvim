local M = {}

---@param paths string[]
---@return string
function M.path_join(paths)
	return table.concat(paths, "/")
end

function M.ishidden(file)
	return vim.startswith(file, ".")
end
return M
