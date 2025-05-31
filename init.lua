vim.o.termguicolors = true
vim.o.linebreak = true
require("lazysetup")

require("mappings")

require("options")

require("folds")

require("autocmd")

require("custom.startscreen").setup()

vim.filetype.add({
	extension = { rasi = "rasi", rofi = "rasi", wofi = "rasi" },
	filename = {
		["vifmrc"] = "vim",
	},
	pattern = {
		[".*/kitty/.+%.conf"] = "kitty",
		[".*/hypr/.+%.conf"] = "hyprlang",
		["%.env%.[%w_.-]+"] = "sh",
	},
})
vim.treesitter.language.register("bash", "kitty")

local colorscheme = require("helpers.theme")
vim.cmd.colorscheme(colorscheme)
