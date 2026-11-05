-- This script maps all emoji aliases for easier indexing

local sources = require("./sources")

local emojis = {}

for group, source in pairs(sources.emojis) do
	for char, aliases in pairs(source.emojis) do
		local emoji = { char = char, group = group }

		local names = aliases.names or aliases
		for i = 1, #names do
			emojis[names[i]] = emoji
		end
	end
end

return emojis