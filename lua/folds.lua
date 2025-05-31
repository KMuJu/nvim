local function countWhitespace(str)
	local count = 0
	local tab = vim.opt.tabstop:get()
	for i = 1, #str do
		local char = str:sub(i, i)
		if char == " " then
			count = count + 1
		elseif char == "\t" then
			count = count + tab
		else
			break
		end
	end
	return count
end

-- TODO: Make a good fold function
function _G.fold_text()
	local line = table.concat(vim.fn.getbufline(vim.api.nvim_get_current_buf(), vim.v.foldstart))
	local whitespace = countWhitespace(line)
	line = vim.trim(line)

	local winWidth = vim.api.nvim_win_get_width(0) - 7 -- don't know why 7 works
	local linecount = vim.v.foldend - vim.v.foldstart

	local rightstr = linecount .. " lines"

	local middle = string.rep("-", winWidth - vim.fn.strdisplaywidth(rightstr) - #line)
	-- local middle = string.rep(" ", 20)
	local test = {
		--
	}
	-- print(foldStartLine)
	-- print(gap)

	return string.rep(" ", whitespace) .. line .. middle .. rightstr
end

vim.o.foldmethod = 'expr'
-- Default to treesitter folding
vim.o.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
-- Prefer LSP folding if client supports it
vim.api.nvim_create_autocmd('LspAttach', {
    callback = function(args)
        local client = vim.lsp.get_client_by_id(args.data.client_id)
        if client and client:supports_method('textDocument/foldingRange') then
            local win = vim.api.nvim_get_current_win()
            vim.wo[win][0].foldexpr = 'v:lua.vim.lsp.foldexpr()'
        end
    end,
})
vim.opt.foldenable = false
vim.opt.foldlevel = 99

vim.o.foldtext = "v:lua.fold_text()"

vim.opt.fillchars = { eob = "-", fold = "-" }
