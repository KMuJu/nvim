local map = require("helpers.keys").map

-- Markdown show header
map("n", "<leader>sj", require("custom.pickers.mdheaders").show_headers, "Show markdown headers in telescope")
