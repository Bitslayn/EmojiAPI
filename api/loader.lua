---@type table<EmojiAPI.CategoryName, EmojiAPI.Category>
local emoji_categories = {}
---@type table<EmojiAPI.CategoryName, EmojiAPI.Charsheet>
local emoji_charsheet = {}

local paths = resources:getPaths()
for i = 1, #paths do
	local target

	if paths[i]:find("assets/v2/emojis") then
		target = emoji_categories
	elseif paths[i]:find("assets/v2/font") then
		target = emoji_charsheet
	end

	if target then
		local buffer = data:createBuffer()
		buffer:readFromStream(resources:get(paths[i]) --[[@as InputStream]])
		buffer:setPosition(0)
		target[paths[i]:match("([^/]*)%.json")] = parseJson(buffer:readString())
		buffer:close()
	end
end

local category_name, category = next(emoji_categories)
assert(category, "Failed to load assets!")

local char, emoji = next(category.emojis)
---@cast emoji EmojiAPI.Emoji|string[]

