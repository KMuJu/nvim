-- vim.keymap.set("n", "<leader>pv", "<cmd>Explore<cr>", {silent=true, desc = "Open explore"}) 
local map = require("helpers.keys").map

-- open explorer
map("n", "<leader>pv", "<cmd>Explore<cr>", "Open explore")

-- close buffer
map("n", "<leader>db", "<cmd>bw<cr>", "Delete buffer")

-- save
map({"n", "v", "i"}, "<C-s>", "<cmd>w<cr>", "Save")


map("n", "<ESC>", "<cmd>noh<cr>", "Remove highlights")

-- navigation
map("n", "<C-u>", "<C-u>zz", "Move half page and center")
map("n", "<C-d>", "<C-d>zz", "Move half page and center")

-- Run file
map("n", "<F5>", "<cmd>:lua require('core.filefunctions').runFile()<CR>", "run file")


-- Format file
map("n", "<leader>f", vim.lsp.buf.format)

-- Primeagen conf
map({"n", "v"}, "<leader>y", [["+y]])
map("n", "<leader>Y", [["+Y]])
map({"n", "v"}, "<leader>d", [["_d]])
-- move lines
map("v", "J", ":m '>+1<CR>gv=gv")
map("v", "K", ":m '<-2<CR>gv=gv")

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
map("n", "<C-Up>", ":resize +2<CR>")
map("n", "<C-Down>", ":resize -2<CR>")
map("n", "<C-Left>", ":vertical resize +2<CR>")
map("n", "<C-Right>", ":vertical resize -2<CR>")

-- GIT
map("n", "<leader>hb", "<cmd>Gitsigns toggle_current_line_blame<CR>", "Toggle line blame")

-- Navigate buffers
map("n", "<S-l>", ":bnext<CR>")
map("n", "<S-h>", ":bprevious<CR>")

-- Diagnostic keymaps
map('n', 'gx', function() vim.diagnostic.open_float(nil, {focus=false})end, "Show diagnostics under cursor")

-- Stay in indent mode
map("v", "<", "<gv")
map("v", ">", ">gv")

--diagnostics
map("n", "<leader>i", "<cmd>:lua require('core.functions.diagnostics').change()<CR>", "Change diagnostics")


-------------
-- HARPOON --
-------------
map("n", "<leader>hs", function() require("harpoon.ui").toggle_quick_menu() end, "Open harpoon menu")
map("n", "<leader>ha", function() require("harpoon.mark").add_file() end, "Add file to harpoon")
map("n", "<leader>hy", function() require("harpoon.ui").nav_file(1) end, "Open harpoon file 1")
map("n", "<leader>hu", function() require("harpoon.ui").nav_file(2) end, "Open harpoon file 2")
map("n", "<leader>hi", function() require("harpoon.ui").nav_file(3) end, "Open harpoon file 3")
map("n", "<leader>hi", function() require("harpoon.ui").nav_next() end, "Open next harpoon file")
map("n", "<leader>ho", function() require("harpoon.ui").nav_prev() end, "Open previous harpoon file")


-- cellular automata
map("n", "<leader>fmr", "<cmd>CellularAutomaton make_it_rain<CR>", "Make it rain")
map("n", "<leader>fml", "<cmd>CellularAutomaton game_of_life<CR>", "Game of life")


map("n", "<C-Up>", ":resize +2<CR>")
map("n", "<C-Down>", ":resize -2<CR>")
map("n", "<C-Left>", ":vertical resize +2<CR>")
map("n", "<C-Right>", ":vertical resize -2<CR>")
