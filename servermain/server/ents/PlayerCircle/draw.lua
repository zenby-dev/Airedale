---
-- Created by IntelliJ IDEA.
-- User: ZenX2
-- Date: 11/24/11
-- Time: 11:01 AM
--

return
function(self)

	local g = love.graphics
	self.img:Draw()
	g.setColor(255, 255, 255, 255)
	g.push()
	local tv = Vec2(self.pos.x - 30, self.pos.y - 55)
	g.translate(tv.x, tv.y)
	g.print((GetPeer(self.ci).name or "No Name"), 0, 0)
	g.pop()

end
