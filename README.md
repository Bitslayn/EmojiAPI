# EmojiAPI

FOX's EmojiAPI is an API that allows you to access certain information about Figura emojis.

## Setup Instructions

- Download [EmojiAPI.lua](https://github.com/Bitslayn/EmojiAPI/blob/main/EmojiAPI.lua) or view [raw](https://raw.githubusercontent.com/Bitslayn/EmojiAPI/refs/heads/main/EmojiAPI.lua) and click `Save As...` in your context menu
- Move the script to your avatar and require

> [!CAUTION]
> When requiring, you may want to check if the assets are accessible to you. This may not immediately be the case, so it is important to call `api:isLoaded()`.

```lua
local EmojiAPI = require("EmojiAPI")

if EmojiAPI:isLoaded() then
	printJson(EmojiAPI:getEmoji("fox"):asComponent())
end
```

## Nameplates

The most common usecase I see this used is in nameplate hovertexts. This example is also useful anywhere Figura doesn't automatically convert emojis.

`EmojiAPI:of(alias)` is shorthand for `EmojiAPI:getEmoji(alias):asComponent()`.

> [!WARNING]
> This snippet was written for versions 1.21.4 and below. Rename `hoverEvent` -> `hover_event` and `contents` -> `value` on later versions to fix issues.

```lua
local EmojiAPI = require("EmojiAPI")

local hover_text

if EmojiAPI:isLoaded() then -- Remember to check if the API is loaded!
	hover_text = {
		{ text = "she/her " },
		EmojiAPI:of("pride"),
		EmojiAPI:of("fox"),
		EmojiAPI:of("fox_tail"),
	}
end

nameplate.ALL:setText(toJson({
	text = "${name} ${badges}",
	color = avatar:getColor(),
	hoverEvent = {
		action = "show_text",
		contents = hover_text
	}
}))
```

## Textures

This example shows how to create a SpriteTask using an emoji's texture. You can apply the same logic to anything that expects a texture and UV, like action wheels.

This guide introduces `emoji:getTexturePath()` and `emoji:getUV()`.

```lua
local EmojiAPI = require("EmojiAPI")

local Gui = models:newPart("Gui", "Gui")

if EmojiAPI:isLoaded() then -- Remember to check if the API is loaded!
	local emoji = EmojiAPI:getEmoji("fox")
	if not emoji then return end

	local texture = textures:fromVanilla("animal_emojis", emoji:getTexturePath())
	local uv = emoji:getUV()

	Gui:newSprite("fox_emoji")
		:texture(texture, texture:getDimensions():unpack()) -- Texture and size
		:uvPixels(uv) -- UV offset
		:region(8, 8) -- Emojis are 8x8
		:size(48, 48) -- Task size
end
```

# Animated Textures

For animated emojis, it is possible to view the number of frames as well as ticks per frame. These include `emoji:getFrameCount()` and `emoji:getFrametime()`.

```lua
-- WIP
```
