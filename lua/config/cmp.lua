local cmp = require("cmp")
local luasnip = require("luasnip")

local path = vim.fn.stdpath("config") .. "/snippets"
require("luasnip/loaders/from_vscode").lazy_load({ paths = { path } })
require("luasnip/loaders/from_vscode").lazy_load()

local cmp_select = { behavior = cmp.SelectBehavior.Select }

cmp.setup({
	window = {
		completion = cmp.config.window.bordered(),
		documentation = cmp.config.window.bordered(),
	},
	snippet = {
		expand = function(args)
			luasnip.lsp_expand(args.body)
		end,
	},
	mapping = {
		["<C-k>"] = cmp.mapping.select_prev_item(cmp_select),
		["<C-j>"] = cmp.mapping.select_next_item(cmp_select),
		-- ["<CR>"] = cmp.mapping.confirm({
		-- 	behavior = cmp.ConfirmBehavior.Replace,
		-- 	select = false,
		-- }),
		["<C-space>"] = cmp.mapping.confirm({
			behavior = cmp.ConfirmBehavior.Replace,
			select = false,
		}),
		["<C-n>"] = cmp.mapping(function(fallback)
			-- if cmp.visible() then
			-- 	cmp.select_next_item()
			if luasnip.expand_or_jumpable() then
				luasnip.expand_or_jump()
			else
				fallback()
			end
		end, { "i", "s" }),

		["<C-b>"] = cmp.mapping(function(fallback)
			-- if cmp.visible() then
			-- 	cmp.select_prev_item()
			if luasnip.jumpable(-1) then
				luasnip.jump(-1)
			else
				fallback()
			end
		end, { "i", "s" }),

		["<C-l>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.close()
			else
				fallback()
			end
		end, { "i", "s" }),
	},
	sources = {

		{
			name = "vimtex",
			priority = 80,
		},
		{
			name = "nvim_lsp",
			priority = 70,
		},
		{
			name = "luasnip",
			priority = 80,
		},
		{
			name = "buffer",
			priority = 10,
		},
		{
			name = "path",
			priority = 100,
		},
	},
})
