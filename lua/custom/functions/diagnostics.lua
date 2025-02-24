local M = {}

M.show = false

M.signs = { Error = "E ", Warn = " ", Hint = "H ", Info = " " }

M.diag1 = {
	virtual_text = false,
	signs = {
		active = M.signs,
	},
	update_in_insert = true,
	underline = true,
	severity_sort = true,
	float = {
		focusable = false,
		style = "minimal",
		border = "rounded",
		source = "always",
		header = "",
		prefix = "",
	},
}

M.diag2 = {
	virtual_text = true,
	signs = {
		active = M.signs,
	},
	update_in_insert = true,
	underline = true,
	severity_sort = true,
	float = {
		focusable = false,
		style = "minimal",
		border = "rounded",
		source = "always",
		header = "",
		prefix = "",
	},
}

function M.change()
	if M.show then
		vim.diagnostic.config(M.diag1)
		M.show = false
	else
		vim.diagnostic.config(M.diag2)
		M.show = true
	end
end

return M
