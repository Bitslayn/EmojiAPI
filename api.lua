---@type table<string, { char: EmojiAPI.UnicodeChar, group: EmojiAPI.EmojiKey }>
local aliases = require("./providers/aliases")

---@class EmojiAPI
local api = {}

---@class EmojiAPI.Emoji
local class = {}

---Returns an emoji by its alias
---@param alias string
---@return EmojiAPI.Emoji?
---@nodiscard
function api:getEmoji(alias)
	alias = alias:match("[^:]+")
	if not aliases[alias] then return end
	return setmetatable({}, {
		__index = setmetatable(aliases[alias], { __index = class }),
		__newindex = function() error("Emojis are read-only", 2) end,
		__metatable = false,
		__type = "EmojiAPI.Emoji",
	})
end

return api
