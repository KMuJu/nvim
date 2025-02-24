-- Run file
vim.keymap.set("n", "<F5>", function()
	vim.cmd(":wa")
	local width = vim.api.nvim_win_get_width(0)
	local height = vim.api.nvim_win_get_height(0)
	-- Vertical split if width is larger than height
	if width / 2 + 10 > height and width > 40 then
		vim.cmd(":vsplit")
	elseif height > 20 then
		vim.cmd(":botright split")
	end
	vim.cmd(":term clear;python %")
end, { buffer = true, desc = "run file" })
