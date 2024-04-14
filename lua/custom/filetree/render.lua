local constants = require("custom.filetree.const")
local dev_icons = require("nvim-web-devicons")

local M = {}
local highlight_id = vim.api.nvim_create_namespace(constants.NAME)

---@param tree FileTree
---@return table<string>, table<string>
local function get_visible_names(tree)
	local names = {}
	local highlights = {}
	---@type string, Node
	for name, node in pairs(tree.tree) do
		local icon
		local hl
		if node.type ~= "directory" then
			icon, hl = dev_icons.get_icon(name, node.extension, { default = true })
		else
			icon = ""
			hl = "Directory"
		end
		table.insert(highlights, hl)
		table.insert(names, icon .. " " .. name)
	end
	return names, highlights
end

-- Creates a buffer, will return the id of the left window
---@return integer, integer
local function create_buf()
	local win = vim.api.nvim_get_current_win()
	local buf = vim.api.nvim_create_buf(false, true)

	vim.api.nvim_set_option_value("bufhidden", "wipe", { buf = buf })
	vim.api.nvim_set_option_value("buftype", "nofile", { buf = buf })
	vim.api.nvim_set_option_value("filetype", constants.name, { buf = buf })
	vim.api.nvim_set_option_value("swapfile", false, { buf = buf })

	vim.api.nvim_win_set_buf(win, buf)

	-- vim.cmd("vsplit")

	return buf, -1
end

---@param tree FileTree
---@return integer
function M.draw(tree)
	local names, highlights = get_visible_names(tree)
	local buf, _ = create_buf()

	vim.api.nvim_buf_set_lines(buf, 0, 1, true, names)

	local i = 1
	for _, hl in pairs(highlights) do
		vim.api.nvim_buf_set_extmark(buf, highlight_id, i - 1, 0, {
			end_row = i,
			hl_group = hl,
		})
		i = i + 1
	end
	return buf
end

return M
