local providers = toJson({
	sources = require("./providers/sources"),
	aliases = require("./providers/aliases"),
})

avatar:store("EmojiAPI$getAssets", function()
	return providers
end)

return providers
