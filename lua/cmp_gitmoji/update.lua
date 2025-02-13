-- Generates the emoji data Lua file using this as a source: https://raw.githubusercontent.com/nvim-telescope/telescope-symbols.nvim/master/data/telescope-sources/gitmoji.json

local M = {}

M._read = function(path)
	return vim.fn.json_decode(vim.fn.readfile(path))
end

M._write = function(path, data)
	local h = io.open(path, "w")
	h:write(data)
	io.close(h)
end

M.to_string = function(chars)
	local nrs = {}
	for _, char in ipairs(chars) do
		table.insert(nrs, vim.fn.eval(([[char2nr("\U%s")]]):format(char)))
	end
	return vim.fn.list2str(nrs, true)
end

M.to_item = function(emoji, short_name)
	short_name = ":" .. short_name .. ":"
	return ("{ word = '%s'; label = '%s'; insertText = '%s'; filterText = '%s' };\n"):format(
		short_name,
		emoji .. " " .. short_name,
		emoji,
		short_name
	)
end

M.update = function()
	local items = ""
	for _, emoji in ipairs(M._read("./gitmoji.json")) do
		local char = M.to_string(vim.split(emoji.unified, "-"))

		local valid = true
		valid = valid and vim.fn.strdisplaywidth(char) <= 2 -- Ignore invalid ligatures
		if valid then
			items = items .. M.to_item(char, emoji.short_name)
		end
	end
	M._write("./items.lua", ("return {\n%s}"):format(items))
end

return M
