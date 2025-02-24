local map = require("helpers.keys").map

vim.opt_local.shiftwidth = 2
vim.opt_local.tabstop = 2
vim.opt_local.softtabstop = 2

-- Markdown show header
vim.keymap.set(
	"n",
	"<leader>sj",
	require("custom.pickers.mdheaders").show_headers,
	{ buffer = true, desc = "Show markdown headers in telescope" }
)
vim.keymap.set("n", "<leader>sh", require("custom.mdOutline").open, { buffer = true, desc = "Open markdown outline" })
