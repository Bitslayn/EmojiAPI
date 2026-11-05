---@type table<string, { char: EmojiAPI.UnicodeChar, group: EmojiAPI.EmojiKey }>
local aliases = require("./providers/aliases")

---@class EmojiAPI
local api = {}

---@class EmojiAPI.Emoji
local class = {}

---@type table<string, EmojiAPI.Emoji>
local emoji_cache = {}

---@return EmojiAPI.Emoji?
---@nodiscard
function api:getEmoji(alias)
	alias = alias:match("[^:]+")
	if not aliases[alias] then return end

	if not emoji_cache[alias] then
		local emoji = aliases[alias]

		emoji_cache[alias] = setmetatable({}, {
			__index = setmetatable(emoji, { __index = class }),
			__newindex = function() error("Emojis are read-only", 2) end,
			__metatable = false,
			__type = "EmojiAPI.Emoji",
		})
	end

	return emoji_cache[alias]
end

return api
