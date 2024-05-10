local pickers = require("telescope.pickers")
local finders = require("telescope.finders")
local config = require("telescope.config").values
local actions = require("telescope.actions")
local action_state = require("telescope.actions.state")

local M = {}

local function get_root(bufnr)
	local parser = vim.treesitter.get_parser(bufnr, "markdown", {})
	local tree = parser:parse()[1]
	return tree:root()
end

local header = vim.treesitter.query.parse(
	"markdown",
	[[
(atx_heading) @string
]]
)

local function get_headers(bufnr)
	local root = get_root(bufnr)

	local headers = {}

	for id, node in header:iter_captures(root, bufnr, 0, -1) do
		local range = { node:range() }
		local row = range[1]
		local header = {
			line = vim.treesitter.get_node_text(node, bufnr),
			row = row + 1,
			id = id,
		}
		table.insert(headers, header)
	end

	return headers
end

function M.show_headers(opts)
	local bufnr = vim.api.nvim_get_current_buf()
	if vim.bo[bufnr].filetype ~= "markdown" then
		print("Feil filtype")
		return
	end
	local headers = get_headers(bufnr)
	print(vim.inspect(headers))
	pickers
		.new(opts, {
			finder = finders.new_table({
				results = headers,
				entry_maker = function(entry)
					return {
						value = entry,
						display = entry.line,
						ordinal = entry.line,
					}
				end,
			}),
			sorter = config.generic_sorter(opts),
			attach_mappings = function(prompt_bufnr)
				actions.select_default:replace(function()
					local selection = action_state.get_selected_entry()
					local rowstr = tostring(selection.value.row)
					actions.close(prompt_bufnr)
					vim.cmd(rowstr)
				end)
				return true
			end,
		})
		:find()
end

return M
