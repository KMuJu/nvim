local M = {}

function M.runFile()
	if vim.bo.filetype == "python" then
		vim.cmd(":wa")
		vim.cmd(":term clear;python %")
	end
end

return M
