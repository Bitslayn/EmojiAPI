local promise = require("./loader")

local function await()
	if promise() then
		print(require("./api")(promise()))
		events.tick:remove(await)
	end
end
events.tick:register(await)