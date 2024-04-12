local M = {}

local name = "Holters"
local highlight_id = vim.api.nvim_create_namespace(name)
M.name = name

local autocmd_group = vim.api.nvim_create_augroup(name, {})

local function unlock_buf(buf)
	vim.api.nvim_set_option_value("modifiable", true, { buf = buf })
end

local function lock_buf(buf)
	vim.api.nvim_set_option_value("modifiable", false, { buf = buf })
end

local function set_options()
	vim.opt_local.number = false -- disable line numbers
	vim.opt_local.relativenumber = false -- disable relative line numbers
	vim.opt_local.list = false -- disable displaying whitespace
	vim.opt_local.fillchars = { eob = " " } -- do not display "~" on each new line
	vim.opt_local.colorcolumn = "0" -- disable colorcolumn
end

---@param default number
---@return number
M.createBuf = function(default)
	local bufnr = vim.api.nvim_create_buf(false, true)

	vim.api.nvim_set_option_value("bufhidden", "wipe", { buf = bufnr })
	vim.api.nvim_set_option_value("buftype", "nofile", { buf = bufnr })
	vim.api.nvim_set_option_value("filetype", name, { buf = bufnr })
	vim.api.nvim_set_option_value("swapfile", false, { buf = bufnr })

	vim.api.nvim_set_current_buf(bufnr)

	vim.api.nvim_buf_delete(default, { force = true })
	return bufnr
end

M.fillBuf = function(buf)
	-- " /$$   /$$           /$$   /$$",
	-- "| $$  | $$          | $$  | $$                                  ",
	-- "| $$  | $$  /$$$$$$ | $$ /$$$$$$    /$$$$$$   /$$$$$$   /$$$$$$$",
	-- "| $$$$$$$$ /$$__  $$| $$|_  $$_/   /$$__  $$ /$$__  $$ /$$_____/",
	-- "| $$__  $$| $$  \\ $$| $$  | $$    | $$$$$$$$| $$  \\__/|  $$$$$$",
	-- "| $$  | $$| $$  | $$| $$  | $$ /$$| $$_____/| $$       ____  $$",
	-- "| $$  | $$|  $$$$$$/| $$  |  $$$$/|  $$$$$$$| $$       /$$$$$$$/",
	-- "|__/  |__/ \\______/ |__/   \\___/   \\_______/|__/      |_______/ ",
	-- TODO: Use the name of the directory
	local lines = {
		"                                                                                                          ",
		" ██████  ██████ ██████████████ ██████     ██████████████ ██████████████ ████████████████   ██████████████ ",
		" ██░░██  ██░░██ ██░░░░░░░░░░██ ██░░██     ██░░░░░░░░░░██ ██░░░░░░░░░░██ ██░░░░░░░░░░░░██   ██░░░░░░░░░░██ ",
		" ██░░██  ██░░██ ██░░██████░░██ ██░░██     ██████░░██████ ██░░██████████ ██░░████████░░██   ██░░██████████ ",
		" ██░░██  ██░░██ ██░░██  ██░░██ ██░░██         ██░░██     ██░░██         ██░░██    ██░░██   ██░░██         ",
		" ██░░██████░░██ ██░░██  ██░░██ ██░░██         ██░░██     ██░░██████████ ██░░████████░░██   ██░░██████████ ",
		" ██░░░░░░░░░░██ ██░░██  ██░░██ ██░░██         ██░░██     ██░░░░░░░░░░██ ██░░░░░░░░░░░░██   ██░░░░░░░░░░██ ",
		" ██░░██████░░██ ██░░██  ██░░██ ██░░██         ██░░██     ██░░██████████ ██░░██████░░████   ██████████░░██ ",
		" ██░░██  ██░░██ ██░░██  ██░░██ ██░░██         ██░░██     ██░░██         ██░░██  ██░░██             ██░░██ ",
		" ██░░██  ██░░██ ██░░██████░░██ ██░░██████████ ██░░██     ██░░██████████ ██░░██  ██░░██████ ██████████░░██ ",
		" ██░░██  ██░░██ ██░░░░░░░░░░██ ██░░░░░░░░░░██ ██░░██     ██░░░░░░░░░░██ ██░░██  ██░░░░░░██ ██░░░░░░░░░░██ ",
		" ██████  ██████ ██████████████ ██████████████ ██████     ██████████████ ██████  ██████████ ██████████████ ",
		"                                                                                                          ",
	}

	local start_row = 0
	local start_col = 0
	local win = vim.fn.bufwinid(buf)
	local width = vim.api.nvim_win_get_width(win)
	local height = vim.api.nvim_win_get_height(win)
	local top = math.floor((height - #lines) / 2)
	local left = math.floor((width - #lines[1]) / 2)

	local topOffset = -0

	for _ = 1, top + topOffset do
		table.insert(lines, 1, "")
	end

	local spaceWidth = ""
	for _ = 1, left do
		spaceWidth = spaceWidth .. " "
	end

	for i, _ in ipairs(lines) do
		lines[i] = spaceWidth .. lines[i]
	end

	vim.api.nvim_buf_set_lines(buf, start_row, start_row, true, lines)
	vim.api.nvim_buf_set_extmark(buf, highlight_id, start_row, start_col, {
		end_row = start_row + #lines,
		hl_group = name .. "Title",
	})
end

M.run = function()
	local curr = vim.api.nvim_get_current_buf()
	-- local currname = vim.api.nvim_buf_get_name(curr)
	-- local filetype = vim.api.nvim_get_option_value("filetype", { buf = curr })

	local buf = M.createBuf(curr)
	M.fillBuf(buf)

	set_options()
	lock_buf(buf)
end

M.setup = function()
	vim.api.nvim_create_autocmd("UiEnter", {
		group = autocmd_group,
		callback = function()
			if next(vim.fn.argv()) ~= nil then
				-- neovim was opened with files
				return
			end
			M.run()
		end,
		once = true,
	})
end

return M
