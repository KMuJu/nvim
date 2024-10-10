-- return {}

local function next_is_whitespace(bufnr, cursor)
	local x, y = unpack(cursor)
	local line = vim.api.nvim_buf_get_lines(bufnr, x, x + 1, true)[1]
	local rest = string.sub(line, y + 1)

	return rest == "" or rest:match("^%s+$")
end

return {
	"steelsojka/pears.nvim",
	config = function()
		local R = require("pears.rule")
		require("pears").setup(function(conf)
			-- conf.preset "tag-matching"

			conf.pair("(", {
				close = ")",
				expand_when = function(char_context)
					return next_is_whitespace(char_context.bufnr, char_context.cursor)
				end,
			})

			conf.pair("'", {
				close = "'",
				expand_when = function(char_context)
					return next_is_whitespace(char_context.bufnr, char_context.cursor)
				end,
			})
			conf.pair('"', {
				close = '"',
				expand_when = function(char_context)
					return next_is_whitespace(char_context.bufnr, char_context.cursor)
				end,
			})
			conf.pair("(", {
				close = ")",
				expand_when = function(char_context)
					return next_is_whitespace(char_context.bufnr, char_context.cursor)
				end,
			})
			conf.pair("{", {
				close = "}",
				expand_when = function(char_context)
					return next_is_whitespace(char_context.bufnr, char_context.cursor)
				end,
			})
		end)
	end,
}
