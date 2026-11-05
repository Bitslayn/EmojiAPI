-- !! 65536 instruction budget !!
-- Currently within budget (50328 instructions)

local t = avatar:getCurrentInstructions()
require("./lib/emojis")
print(avatar:getCurrentInstructions() - t - 4)

-- avatar:store("EmojiAPI", api)

-- return api
