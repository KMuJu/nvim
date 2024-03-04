-- TODO: Make a good fold function
function _G.fold_text()
    local line = vim.fn.getline(vim.v.foldstart)
    local winWidth = vim.api.nvim_win_get_width(0) - 7 -- don't know why 7 works
    local linecount = vim.v.foldend - vim.v.foldstart

    local rightstr = linecount .. " lines"

    local middle = string.rep("-", winWidth - vim.fn.strdisplaywidth(rightstr) - #line)
    -- local middle = string.rep(" ", 20)

    return line .. middle .. rightstr
end

vim.o.foldtext = "v:lua.fold_text()"

vim.opt.fillchars = { eob = "-", fold = "-" }
