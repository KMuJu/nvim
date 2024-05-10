local opts = {
	shiftwidth = 4,
	tabstop = 4,
	expandtab = true,
	wrap = false,
	termguicolors = true,
	number = true,
	relativenumber = true,
	scrolloff = 7,

	mouse = "a",
	-- Ignore case on search
	ignorecase = true,
	smartcase = true,
	undofile = true,
	splitright = true,
	splitbelow = false,

	-- Preview substitutions live, as you type!
	inccommand = "split",

	-- Show which line your cursor is on
	cursorline = true,
	-- signcolumn = "yes",
}

-- Set options from table
for opt, val in pairs(opts) do
	vim.o[opt] = val
end

vim.g.ftplugin_sql_omni_key = "<C-j>"

-- vim.o.updatetime = 250
-- vim.cmd [[autocmd! CursorHold,CursorHoldI * lua vim.diagnostic.open_float(nil, {focus=false})]]
