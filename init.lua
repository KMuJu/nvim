vim.o.termguicolors = true
require("core.lazy")

require("core.mappings")

require("core.options")

local colorscheme = require("helpers.theme")
vim.cmd.colorscheme(colorscheme)
