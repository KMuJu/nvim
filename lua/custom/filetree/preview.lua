local constants = require("custom.filetree.const")
local utils = require("custom.filetree.utils")

local Previewer = {}
Previewer.__index = Previewer

---@class Previewer
---@field buf integer
---@field win integer
---@field preview_path string
function Previewer:new()
	return setmetatable({
		buf = 0,
		win = 0,
		previewPath = "",
	}, self)
end

---@param lines table<string>
---@param buftype string|nil
---@param filetype string
---@return integer
local function create_buf(lines, buftype, filetype)
	local buf = vim.api.nvim_create_buf(false, true)
	vim.api.nvim_buf_set_lines(buf, 0, 0, true, lines)
	vim.api.nvim_set_option_value("bufhidden", "wipe", { buf = buf })
	if buftype ~= nil then
		vim.api.nvim_set_option_value("buftype", buftype, { buf = buf })
	end
	vim.api.nvim_set_option_value("filetype", filetype, { buf = buf })
	vim.api.nvim_set_option_value("swapfile", false, { buf = buf })

	return buf
end

---@param buf integer
---@return integer
local function create_preview_win(buf)
	local width = vim.api.nvim_win_get_width(0)
	local height = vim.api.nvim_win_get_height(0)
	local win = vim.api.nvim_open_win(buf, false, {
		relative = "win",
		row = 0,
		col = math.floor(width / 2),
		width = math.ceil(width / 2),
		height = height,
	})
	-- vim.api.nvim_win_set_option(win, "winhl", "Normal:TelescopePreviewNormal")
	vim.api.nvim_win_set_option(win, "signcolumn", "no")
	vim.api.nvim_win_set_option(win, "foldlevel", 100)
	vim.api.nvim_win_set_option(win, "wrap", false)
	vim.api.nvim_win_set_option(win, "scrollbind", false)
	return win
end

---@param win integer
---@param buf integer
local function update_win(win, buf)
	vim.api.nvim_win_set_buf(win, buf)
end

function Previewer:init(lines)
	self.buf = create_buf(lines, "nofile", constants.NAME)
	self.win = create_preview_win(self.buf)
end

function Previewer:preview(path)
	-- print("Starting cat on", path)
	local filetype = utils.filetype_detect(path)
	if filetype == nil then
		return
	end
	-- print("filetype " .. filetype)
	-- vim.fn.jobstart({ "cat", "--", path }, {
	local n = 0
	vim.fn.jobstart({ "less", "-RS", path }, {
		on_stdout = function(_, data, _)
			if n == 1 then
				return
			end
			print("Got output")
			local buf = create_buf(data, nil, filetype)
			update_win(self.win, buf)
			n = n + 1
		end,
	})
end

return Previewer
