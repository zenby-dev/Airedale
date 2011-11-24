---
-- Created by IntelliJ IDEA.
-- User: ZenX2
-- Date: 11/24/11
-- Time: 11:01 AM
--

return
function(self)

	local g = love.graphics
	g.setColor(self.col[1], self.col[2], self.col[3], self.col[4])
	g.circle("fill", self.pos.x, self.pos.y, 30)
	g.setColor(255, 255, 255, 255)
	g.print((self.ci.name or "No Name"), self.pos.x - 15, self.pos.y - 20)

end
