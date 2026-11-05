-- !! 65536 instruction budget !!
-- Currently within budget (50328 instructions)

local t = avatar:getCurrentInstructions()
require("./providers/aliases")
print(avatar:getCurrentInstructions() - t - 4)

-- avatar:store("EmojiAPI", api)

-- return api
