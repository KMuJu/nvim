vim.o.termguicolors = true
vim.o.linebreak = true
require("core.lazy")

require("core.mappings")

require("core.options")

local colorscheme = require("helpers.theme")
vim.cmd.colorscheme(colorscheme)
