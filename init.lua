local promise = require("./api/loader")

local function await()
	local emoji_aliases = promise()
	if not emoji_aliases then return end

	avatar:store("EmojiAPI", require("./api/emoji")(emoji_aliases))
	events.tick:remove(await)
end
events.tick:register(await)
