vim.keymap.set("n", "<leader>x", "<cmd>.lua<CR>", {buffer = true, desc = "Execute the current line" })
vim.keymap.set("n", "<leader><leader>x", "<cmd>source %<CR>", {buffer = true, desc = "Execute the current file" })
