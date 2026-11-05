-- This script loads all json files from assets/v2/emojis/* and assets/v2/font/*

local sources = {
	---@type table<EmojiAPI.EmojiKey, EmojiAPI.EmojiGroup>
	emojis = {},
	---@type table<EmojiAPI.FontKey, EmojiAPI.FontGroup>
	font = {},
}

local paths = resources:getPaths()
for i = 1, #paths do
	local source, key = paths[i]:match("assets/v2/([^/]+)/(.*)%.json")

	if source then
		local buffer = data:createBuffer()
		buffer:readFromStream(resources:get(paths[i]) --[[@as InputStream]])
		buffer:setPosition(0)
		sources[source][key] = parseJson(buffer:readString())
		buffer:close()
	end
end

--[[
In your avatar.json, add these paths to your "resources" array:
	"resources": [
		"**/assets/v2/emojis/**.json",
		"**/assets/v2/font/**.json"
	]
]]
assert(next(sources.emojis), "Failed to load assets")

return sources
