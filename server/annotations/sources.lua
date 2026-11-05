---@meta

---@alias EmojiAPI.EmojiNames string[]

---@class EmojiAPI.EmojiComponent
---@field names EmojiAPI.EmojiNames Table of emoji aliases
---@field shortcuts string[]? Table of unicode characters which get replaced by this emoji
---@field frames integer? For animated emojis, the frame count
---@field frametime integer? For animated emojis, the number of ticks to show each frame
---@field color integer? The text color applied to this emoji by default

---@class EmojiAPI.EmojiGroup
---@field width integer?
---@field height integer?
---@field blacklist EmojiAPI.UnicodeString Emojis that are blacklisted and cannot be used in the nameplate
---@field emojis table<EmojiAPI.UnicodeChar, EmojiAPI.EmojiNames|EmojiAPI.EmojiComponent> List of emojis

---@class EmojiAPI.FontGroup
---@field providers EmojiAPI.FontGroup.Providers[] List of font providers

---@alias EmojiAPI.FontGroup.Providers
---| EmojiAPI.FontGroup.Provider.Bitmap
---| EmojiAPI.FontGroup.Provider.Space

---@class EmojiAPI.FontGroup.Provider.Bitmap
---@field type "bitmap"
---@field file string The resource path for these characters
---@field ascent integer
---@field chars EmojiAPI.UnicodeString[] Grid of unicode characters

---@class EmojiAPI.FontGroup.Provider.Space
---@field type "space"
---@field advances table<EmojiAPI.UnicodeChar, integer> This character's width in pixels