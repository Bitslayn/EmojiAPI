---@alias EmojiAPI.UnicodeChar string A single unicode character
---@alias EmojiAPI.UnicodeString string A string of unicode characters
---@alias EmojiAPI.CategoryName
---| "animal"
---| "animated"
---| "face_happy"
---| "face_misc"
---| "face_sad"
---| "face_stress"
---| "festive"
---| "flag_a-d"
---| "flag_e-k"
---| "flag_l-q"
---| "flag_r-z"
---| "food"
---| "gesture"
---| "heart"
---| "letters"
---| "logo"
---| "meme"
---| "minecraft_animated"
---| "minecraft_blocks"
---| "minecraft_items"
---| "minecraft_mobs"
---| "misc"
---| "nature"
---| "object"
---| "portrait"
---| "pride"
---| "reference"
---| "reference_bloons"
---| "reference_logo"
---| "reference_retro"
---| "symbol"

---@class EmojiAPI.Emoji
---@field names string[] Table of emoji aliases
---@field shortcuts string[]? Table of unicode characters which get replaced by this emoji
---@field frames integer? For animated emojis, the frame count
---@field frametime integer? For animated emojis, the number of ticks to show each frame
---@field color integer? The text color applied to this emoji by default

---@class EmojiAPI.EmojiExtended: EmojiAPI.Emoji
---@field char EmojiAPI.UnicodeChar This emoji's unicode character
---@field category EmojiAPI.CategoryName This emoji's category name
---@field font string The font used to render this emoji
---@field blacklisted boolean Whether this emoji is blacklisted

---@class EmojiAPI.Category
---@field width integer?
---@field height integer?
---@field blacklist EmojiAPI.UnicodeString Emojis that are blacklisted and cannot be used in the nameplate
---@field emojis table<EmojiAPI.UnicodeChar, string[]|EmojiAPI.Emoji> List of emojis

---@class EmojiAPI.Charsheet
---@field providers EmojiAPI.Charsheet.Providers List of font providers

---@alias EmojiAPI.Charsheet.Providers
---| EmojiAPI.Charsheet.Provider.Bitmap
---| EmojiAPI.Charsheet.Provider.Space

---@class EmojiAPI.Charsheet.Provider.Bitmap
---@field type "bitmap"
---@field file string The resource path for these characters
---@field ascent integer
---@field chars EmojiAPI.UnicodeString[] Grid of unicode characters

---@class EmojiAPI.Charsheet.Provider.Space
---@field type "space"
---@field advances table<EmojiAPI.UnicodeChar, integer> This character's width in pixels

---@type table<EmojiAPI.CategoryName, EmojiAPI.Category>
local emoji_categories = {}
---@type table<EmojiAPI.CategoryName, EmojiAPI.Charsheet>
local emoji_charsheet = {}

local paths = resources:getPaths()
for i = 1, #paths do
	local store

	if paths[i]:find("assets/v2/emojis") then
		store = emoji_categories
	elseif paths[i]:find("assets/v2/font") then
		store = emoji_charsheet
	end

	if store then
		local buffer = data:createBuffer()
		buffer:readFromStream(resources:get(paths[i]) --[[@as InputStream]])
		buffer:setPosition(0)
		store[paths[i]:match("([^/]*)%.json")] = parseJson(buffer:readString())
		buffer:close()
	end
end

local is_done = false

---@type table<string, EmojiAPI.EmojiExtended>
local emoji_aliases = {}
local function promise()
	return is_done and emoji_aliases
end

local category_name, category = next(emoji_categories)
local function load_async()
	if not category_name then
		is_done = true
		events.render:remove(load_async)
		return
	end

	---@cast category EmojiAPI.Category

	local emojis = category.emojis
	for char, emoji in pairs(emojis) do
		if emoji.names then
			for j = 1, #emoji.names do
				---@cast emoji EmojiAPI.EmojiExtended
				emoji.char = char
				emoji.category = category_name
				emoji.font = "figura:emoji_" .. category_name
				emoji.blacklisted = category.blacklist:find(emoji.char) ~= nil
				emoji_aliases[emoji.names[j]] = emoji
			end
		else
			for j = 1, #emoji do
				emoji_aliases[emoji[j]] = {
					char = char,
					category = category_name,
					font = "figura:emoji_" .. category_name,
					names = emoji, --[[@as (string[])]]
					blacklisted = category.blacklist:find(char) ~= nil,
				}
			end
		end
	end

	category_name, category = next(emoji_categories, category_name)
end
events.render:register(load_async)

return promise
