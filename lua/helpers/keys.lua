local M = {}

local ok, customMap = pcall(require, "Keymaps.map")

local m = function(mode, lhs, rhs, desc)
	vim.keymap.set(mode, lhs, rhs, { silent = true, desc = desc })
end

local lm = function(lhs, rhs, bufnr, desc)
	vim.keymap.set("n", lhs, rhs, { silent = true, buffer = bufnr, desc = desc })
end

local map = m
local lsp_map = lm

M.map = function(mode, lhs, rhs, desc)
	-- vim.keymap.set(mode, lhs, rhs, { silent = true, desc = desc })
	-- print(mode, lhs, rhs, desc)
	-- if not ok then
	-- 	ok, customMap = pcall(require, "Keymaps.map")
	-- end
	-- if ok then
	-- 	map = customMap.map
	-- else
	-- 	map = m
	-- end
	map = m
	map(mode, lhs, rhs, desc)
end

M.lsp_map = function(lhs, rhs, bufnr, desc)
	-- vim.keymap.set("n", lhs, rhs, { silent = true, buffer = bufnr, desc = desc })
	-- if not ok then
	-- 	ok, customMap = pcall(require, "Keymaps.map")
	-- end
	-- if ok then
	-- 	lsp_map = customMap.lsp_map
	-- else
	-- 	lsp_map = lm
	-- end
	lsp_map = lm
	lsp_map(lhs, rhs, bufnr, "LSP: " .. desc)
end

M.dap_map = function(mode, lhs, rhs, desc)
	M.map(mode, lhs, rhs, "DAP: " .. desc)
end

M.set_leader = function(key)
	vim.g.mapleader = key
	vim.g.maplocalleader = key
	-- M.map({ "n", "v" }, key, "<nop>")
	vim.keymap.set({ "n", "v" }, key, "<nop>")
end

return M
