local map = require("helpers.keys").map
-- Run file
map("n", "<F5>", function()
	vim.cmd(":wa")
	vim.cmd(":term clear;python %")
end, "run file")
