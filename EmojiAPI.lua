local providers = require("./server/init")

---@type { emojis: table<EmojiAPI.EmojiKey, EmojiAPI.EmojiGroup>, font: table<EmojiAPI.FontKey, EmojiAPI.FontGroup> }
local sources = providers.sources
---@type table<string, { char: EmojiAPI.UnicodeChar, group: EmojiAPI.EmojiKey }>
local aliases = providers.aliases

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

---Builds and returns a list of all emoji aliases
---
---This uses a LOT of instructions so don't use this if you can help it
---@return string[]
---@nodiscard
function api:listAliases()
	local list = {}
	local index = 1
	for alias in pairs(aliases) do
		list[index] = alias
		index = index + 1
	end
	return list
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

---Returns the emoji's texture resource path
---@return string
---@nodiscard
function class:getTexturePath()
	return "figura:textures/font/emojis/" .. self.group .. ".png"
end

---Returns the emoji's UV position
---@return Vector2
---@nodiscard
function class:getUV()
	local font = sources.font["emoji_" .. self.group]

	for i = 1, #font.providers do
		local provider = font.providers[i]

		if provider.type == "bitmap" then
			for y = 1, #provider.chars do
				local x = provider.chars[y]:match("()" .. self.char)
				if x then
					return vec((x - 1) / 3, y - 1) * provider.ascent
				end
			end
		end
	end

	return vec(0, 0)
end

---Returns the emoji's frame count
---
---Returns `1` if the emoji isn't animated
---@return integer
---@nodiscard
function class:getFrameCount()
	return sources.emojis[self.group].emojis[self.char].frames or 1
end

---Returns the emoji's frame time
---
---Returns `0` if the emoji isn't animated
---@return integer
---@nodiscard
function class:getFrametime()
	return sources.emojis[self.group].emojis[self.char].frametime or 0
end

return api
