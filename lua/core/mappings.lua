-- vim.keymap.set("n", "<leader>pv", "<cmd>Explore<cr>", {silent=true, desc = "Open explore"}) 
local map = require("helpers.keys").map

-- open explorer
map("n", "<leader>pv", "<cmd>Explore<cr>", "Open explore")

-- close buffer
map("n", "<leader>db", "<cmd>bdelete<cr>", "Delete buffer")

-- save
map({"n", "v", "i"}, "<C-s>", "<cmd>w<cr>", "Save")


map("n", "<ESC>", "<cmd>noh<cr>", "Remove highlights")

-- navigation
map("n", "<C-u>", "<C-u>zz", "Move half page and center")
map("n", "<C-d>", "<C-d>zz", "Move half page and center")

-- Run file
map("n", "<F5>", "<cmd>:lua require('core.filefunctions').runFile()<CR>", "run file")


-- Primeagen conf
map({"n", "v"}, "<leader>y", '"+y', "Copy into + buffer (System clipboard)")
map("n", "<leader>Y", '"+Y', "Copy whole line into + buffer")
map({"n", "v"}, "<leader>d", '"_d', "Delete without yanking")
map("x", "<leader>p", '"_dP', "Peserve yanked text")
-- move lines
map("v", "J", ":m '>+1<CR>gv=gv", "Move lines down and keep selection in visual mode")
map("v", "K", ":m '<-2<CR>gv=gv", "Move lines up and keep selection in visual mode")

-- Zen mode
map("n", "<leader>zz", function()
    require("zen-mode").setup {
        window = {
            width = 100,
            options = { }
        },
    }
    require("zen-mode").toggle()
    vim.wo.wrap = false
    vim.wo.number = true
    vim.wo.rnu = true
end, "Toggle Zen mode")

-- Better window navigation
map("n", "<C-h>", "<C-w><C-h>", "Navigate windows to the left")
map("n", "<C-j>", "<C-w><C-j>", "Navigate windows down")
map("n", "<C-k>", "<C-w><C-k>", "Navigate windows up")
map("n", "<C-l>", "<C-w><C-l>", "Navigate windows to the right")

-- Resize with arrows
map("n", "<C-Up>", ":resize +2<CR>", "Increase size horizontally")
map("n", "<C-Down>", ":resize -2<CR>", "Decrease size horizontally")
map("n", "<C-Left>", ":vertical resize +2<CR>", "Increase size vertically")
map("n", "<C-Right>", ":vertical resize -2<CR>", "Decrease size vertically")

-- GIT
map("n", "<leader>hb", "<cmd>Gitsigns toggle_current_line_blame<CR>", "Toggle line blame")
map("n", "<leader>G", vim.cmd.Git, "Open git fugitive")

-- Navigate buffers
map("n", "<S-l>", ":bnext<CR>", "Next buffer")
map("n", "<S-h>", ":bprevious<CR>", "Precious buffer")

-- Diagnostic keymaps
map('n', 'gx', function() vim.diagnostic.open_float(nil, {focus=false})end, "Show diagnostics under cursor")

-- Stay in indent mode
map("v", "<", "<gv")
map("v", ">", ">gv")

--diagnostics
map("n", "<leader>i", "<cmd>:lua require('core.functions.diagnostics').change()<CR>", "Change diagnostics")

-- Oil
map("n", "<leader>o", "<cmd>Oil<CR>", "Open oil in parent dir")


-------------
-- HARPOON --
-------------
map("n", "<leader>hs", function() require("harpoon.ui").toggle_quick_menu() end, "Open harpoon menu")
map("n", "<leader>ha", function() require("harpoon.mark").add_file() end, "Add file to harpoon")
map("n", "<leader>7", function() require("harpoon.ui").nav_file(1) end, "Open harpoon file 1")
map("n", "<leader>8", function() require("harpoon.ui").nav_file(2) end, "Open harpoon file 2")
map("n", "<leader>9", function() require("harpoon.ui").nav_file(3) end, "Open harpoon file 3")
map("n", "<leader>k", function() require("harpoon.ui").nav_next() end, "Open next harpoon file")
map("n", "<leader>j", function() require("harpoon.ui").nav_prev() end, "Open previous harpoon file")


-- cellular automata
map("n", "<leader>fmr", "<cmd>CellularAutomaton make_it_rain<CR>", "Make it rain")
map("n", "<leader>fml", "<cmd>CellularAutomaton game_of_life<CR>", "Game of life")


map("n", "<C-Up>", ":resize +2<CR>")
map("n", "<C-Down>", ":resize -2<CR>")
map("n", "<C-Left>", ":vertical resize +2<CR>")
map("n", "<C-Right>", ":vertical resize -2<CR>")


-- Run test file
map("n", "<leader>rt", "<cmd>PlenaryBustedFile %<CR>", "Run test on current file")
-- map("n", "<leader>rt", function ()
--     local test = require("mini.test")
--     test.setup()
--     test.run_file()
-- end, "Run test on current file")


-- Nvim scissors
map("n", "<leader>sne", function() require("scissors").editSnippet() end, "Edit snippet")

-- When used in visual mode prefills the selection as body.
map({ "n", "x" }, "<leader>sna", function() require("scissors").addNewSnippet() end, "Add new snippet")
