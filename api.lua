---@type table<string, { char: EmojiAPI.UnicodeChar, group: EmojiAPI.EmojiKey }>
local aliases = require("./providers/aliases")

---@class EmojiAPI
local api = {}

---@class EmojiAPI.Emoji
---@field package char string
---@field package group string
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

---Returns the emoji's JSON component
---
---Alias for `EmojiAPI:getEmoji(alias):asComponent()`
---@param alias string
---@return { text: string?, font: string? }
---@nodiscard
function api:of(alias)
	local emoji = api:getEmoji(alias)
	if not emoji then return {} end
	return emoji:asComponent()
end

---Returns the emoji's JSON component
---@return { text: string, font: string }
---@nodiscard
function class:asComponent()
	return { text = self.char, font = "figura:emoji_" .. self.group }
end

return api
