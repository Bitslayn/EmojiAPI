local providers = {
	sources = require("./providers/sources"),
	aliases = require("./providers/aliases"),
}

avatar:store("EmojiAPI$providers", providers)
return providers
