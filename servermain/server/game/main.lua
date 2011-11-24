---
-- Created by IntelliJ IDEA.
-- User: ZenX2
-- Date: 11/21/11
-- Time: 6:14 PM
--
--SERVER

hook.Add("Draw", "drawinput",
function()

	

end)

function NewCircle(pos)

	send("entsync", {"create", pos, "function(self) love.graphics.setColor(255,255,255,255) love.graphics.circle('fill', self.pos.x, self.pos.y, 10) end", 1})

end