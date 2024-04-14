vim.o.termguicolors = true
vim.o.linebreak = true
require("lazysetup")

require("mappings")

require("options")

require("folds")

require("autocmd")

require("custom.startscreen").setup()

local colorscheme = require("helpers.theme")
vim.cmd.colorscheme(colorscheme)

vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
vim.opt.foldenable = false
vim.opt.foldlevel = 99
