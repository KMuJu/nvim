vim.opt_local.shiftwidth = 2
vim.opt_local.tabstop = 2
vim.opt_local.softtabstop = 2

-- Markdown show header
vim.keymap.set(
    "n",
    "<leader>sj",
    require("custom.pickers.mdheaders").show_headers,
    { buffer = true, desc = "Show markdown headers in telescope" }
)
vim.keymap.set("n", "<leader>sh", require("custom.mdOutline").open, { buffer = true, desc = "Open markdown outline" })

local ts_utils = require('nvim-treesitter.ts_utils')

local function is_in_checkbox()
    local node = ts_utils.get_node_at_cursor()
    if not node then
        return nil
    end

    -- Walk up to find the nearest list_item
    while node do
        if node:type() == "list_item" then
            -- Now check if this list_item has a task_list_marker_unchecked or task_list_marker_checked
            for child in node:iter_children() do
                local child_type = child:type()
                if child_type == "task_list_marker_unchecked" or child_type == "task_list_marker_checked" then
                    return child
                end
            end
            return nil -- Found a list_item, but no checkbox marker
        end
        node = node:parent()
    end

    return nil
end

local function toggle_checkbox()
    local checkbox = is_in_checkbox()
    if not checkbox then
        print("is not checkbox")
        return
    end

    local start_row, start_col, end_row, end_col = checkbox:range()
    local bufnr = vim.api.nvim_get_current_buf()
    local text = vim.api.nvim_buf_get_text(bufnr, start_row, start_col, end_row, end_col, {})[1]

    -- Toggle [ ] <-> [x]
    local new_text
    if text:match("%[ %]") then
      new_text = "[x]"
    elseif text:match("%[x%]") then
      new_text = "[ ]"
    else
      -- Unknown format, don't modify
      return
    end

    -- Replace the text
    vim.api.nvim_buf_set_text(bufnr, start_row, start_col, end_row, end_col, {new_text})
end

vim.keymap.set("n", "<leader><leader>t", toggle_checkbox, { buffer = true, desc = "toggle checkbox" })
