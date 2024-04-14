local Path = require("plenary.path")
local utils = {}

---@param paths string[]
---@return string
function utils.path_join(paths)
	return table.concat(paths, "/")
end

function utils.ishidden(file)
	return vim.startswith(file, ".")
end

function utils.unlock_buf(buf)
	vim.api.nvim_set_option_value("modifiable", true, { buf = buf })
end

function utils.lock_buf(buf)
	vim.api.nvim_set_option_value("modifiable", false, { buf = buf })
end
local detect_from_shebang = function(p)
	local s = p:readbyterange(0, 256)
	if s then
		local lines = vim.split(s, "\n")
		return vim.filetype.match({ contents = lines })
	end
end

local parse_modeline = function(tail)
	if tail:find("vim:") then
		return tail:match(".*:ft=([^: ]*):.*$") or ""
	end
end

local detect_from_modeline = function(p)
	local s = p:readbyterange(-256, 256)
	if s then
		local lines = vim.split(s, "\n")
		local idx = lines[#lines] ~= "" and #lines or #lines - 1
		if idx >= 1 then
			return parse_modeline(lines[idx])
		end
	end
end

function utils.filetype_detect(filepath)
	if type(filepath) ~= string then
		filepath = tostring(filepath)
	end
	local last = string.sub(filepath, #filepath, #filepath)
	if last == "/" then
		return "Dictonary"
	end

	local match = vim.filetype.match({ filename = filepath })
	if match and match ~= "" then
		return match
	end

	local p = Path:new(filepath)
	if p and p:is_file() then
		match = detect_from_shebang(p)
		if match and match ~= "" then
			return match
		end

		match = detect_from_modeline(p)
		if match and match ~= "" then
			return match
		end
	end
end

return utils
