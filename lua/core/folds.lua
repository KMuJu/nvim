-- TODO: Make a good fold function
function _G.fold_text()
    local line = vim.fn.getline(vim.v.foldstart)
    return line
end

vim.o.foldtext = "v:lua.fold_text()"


vim.opt.fillchars = { eob = "-", fold = " " }
