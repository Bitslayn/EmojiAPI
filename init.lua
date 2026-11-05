-- !! 65536 instruction budget !!
-- Currently within budget (47640 instructions)

local t = avatar:getCurrentInstructions()
---@type EmojiAPI
local api = require("./api")
print(avatar:getCurrentInstructions() - t - 4)

avatar:store("EmojiAPI", api)
return api
