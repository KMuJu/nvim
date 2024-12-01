local map = require("helpers.keys").map

vim.opt.shiftwidth = 2
vim.opt.tabstop = 2
vim.opt.softtabstop = 2

-- Markdown show header
map("n", "<leader>sj", require("custom.pickers.mdheaders").show_headers, "Show markdown headers in telescope")
