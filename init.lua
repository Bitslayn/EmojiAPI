local promise = require("./api/loader")

local function await()
	if promise() then
		avatar:store("EmojiAPI", require("./api/emoji")(promise()))
		events.tick:remove(await)
	end
end
events.tick:register(await)