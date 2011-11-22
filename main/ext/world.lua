class.World()

function World:__init(x1, y1, x2, y2, gx, gy, m)

	self.w = love.physics.newWorld(x1, y1, x2, y2)
	self.w:setGravity(gx, gy)
	self.w:setMeter(m)

end

function GetWorld()

	return world.w

end
