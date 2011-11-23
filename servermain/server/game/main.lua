---
-- Created by IntelliJ IDEA.
-- User: ZenX2
-- Date: 11/21/11
-- Time: 6:14 PM
--
--SERVER

hook.Add("Draw", "drawinput",
function()

	love.graphics.setColor(255, 255, 255, 255)
	for k, v in pairs(CLIENTS) do

		local keys = table.concat(v.input, " ")
		love.graphics.print(keys, 20, 20)
		if #v.input > 0 then print(keys) end

	end

end)

