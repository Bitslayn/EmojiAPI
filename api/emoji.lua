local emoji_aliases, status = require("./loader")
---@cast status {done: boolean}

---@class EmojiAPI
local api = {}

---@class Emoji: EmojiAPI.EmojiExtended
local class = {}
local __meta = {
	__index = class,
	__tostring = function(s) return s.char end,
	__metatable = false,
}

---Returns `false` if emojis are still being loaded
---@return boolean
---@nodiscard
function api.isLoaded()
	return status.done
end

---Returns an emoji matching the alias
---@param alias string
---@return Emoji?
---@nodiscard
function api.getEmoji(alias)
	local emoji = emoji_aliases[alias:match(".-([^:]+)")]
	if not emoji then return end
	return setmetatable({
		char = emoji.char,
		category = emoji.category,
		font = emoji.font,
		names = emoji.names,
		shortcuts = emoji.shortcuts,
		frames = emoji.frames,
		frametime = emoji.frametime,
		color = emoji.color,
		blacklisted = emoji.blacklisted,
	}, __meta)
end

return api
