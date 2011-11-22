class.PhysEnt()

function PhysEnt:__init(p, w, h, m, i)
	self.body = love.physics.newBody(GetWorld(), p.x, p.y, m, i)
	self.body:setFixedRotation(false)
	self.shape = love.physics.newRectangleShape(self.body, 0, 0, w, h, i )
	self.drawe = function() end
	self.__entindex = #ents + 1
	ents[self.__entindex] = self
end

function PhysEnt:SetPos(p)
	self.body:setPosition(p.x, p.y)
	if self.image then self.image.p = p end
end

function PhysEnt:GetPos()
	return Vec2(self.body:getWorldCenter())
end

function PhysEnt:SetImage(i)
	self.image = i
end

function PhysEnt:SetDraw(f)
	self.drawe = f
end

function PhysEnt:Body()
	return self.body
end

function PhysEnt:Draw()
   -- self:DrawBoundingBox()
	self.drawe()
end

function PhysEnt:Think()
	if self.image then
		self.image.p = self:GetPos()
		self.image.a = self:Body():getAngle()
	end
end

function PhysEnt:Remove()

	ents[self.__entindex] = nil

end
