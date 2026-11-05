-- This script maps all emoji aliases for easier indexing

---@type { emojis: table<EmojiAPI.EmojiKey, EmojiAPI.EmojiGroup>, font: table<EmojiAPI.FontKey, EmojiAPI.FontGroup> }
local sources = require("./sources")

---@type table<string, { char: EmojiAPI.UnicodeChar, group: EmojiAPI.EmojiKey }>
local aliases = {}

for group, source in pairs(sources.emojis) do
	for char, names in pairs(source.emojis) do
		names = names.names or names

		local emoji = { char = char, group = group }

		for i = 1, #names do
			aliases[names[i]] = emoji
		end
	end
end

return aliases
