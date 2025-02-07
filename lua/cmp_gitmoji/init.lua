local source = {}

source.new = function()
	local self = setmetatable({}, { __index = source })
	self.items = nil
	return self
end

source.get_trigger_characters = function()
	return { ":" }
end

source.get_keyword_pattern = function()
	return [[\%(\s\|^\)\zs:\w*:\?]]
end

source.complete = function(self, request, callback)
	-- Avoid unexpected completion.
	if not vim.regex(self.get_keyword_pattern() .. "$"):match_str(request.context.cursor_before_line) then
		return callback()
	end

	if not self.items then
		self.items = require("cmp_gitmoji.items")
	end

	callback(self.items)
end

return source
