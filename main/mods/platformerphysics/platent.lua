class.PlatEnt()

function PlatEnt:__init(p, s, m)
	self.pos = p
	self.vel = Vec2()
	self.acc = Vec2()
	self.size = s
	self.mass = m
	self.friction = .5
	self.gravity = true
	self.world = world
	self.__entindex = #world.ents + 1
	world.ents[self.__entindex] = self
end

function PlatEnt:ApplyForce(v)

	self.acc = self.acc + v / self.mass

end

function PlatEnt:ApplyAcc(v)

	self.acc = self.acc + v

end

function PlatEnt:ApplyImpulse(v)

	self.vel = self.vel + v / self.mass

end

function PlatEnt:Stop()

	self.vel = Vec2()

end

function PlatEnt:SetPos(v)

	self.pos = v

end

function PlatEnt:SetGravity(b)

	self.gravity = b

end

function PlatEnt:SetFriction(n)

	self.friction = n

end

function PlatEnt:Remove()

	world.ents[self.__entindex] = nil

end

function PlatEnt:SetImage(i, u)

	self.img = i
	if not u then return end
	self.size = Vec2(i.i:getWidth(), i.i:getHeight())

end

function PlatEnt:SetScale(x, y)

	self.img:SetScale(x, y)
	self.size = Vec2(self.img.i:getWidth() * x, self.img.i:getHeight() * y)

end

function PlatEnt:SectPoint(p, v)

	return  (p.x + self.size.x >= v.x and p.y + self.size.y >= v.y)
		and (p.x <= v.x and p.y <= v.y)
		or  (p.x >= v.x and p.y + self.size.y >= v.y)
		and (p.x + self.size.x <= v.x and p.y <= v.y)

end

function PlatEnt:Collides(p, e, ep) --bounding box?

	if self:SectPoint(p, ep)
	or self:SectPoint(p, ep + e.size)
	or self:SectPoint(p, Vec2(ep.x, ep.y + e.size.y))
	or self:SectPoint(p, Vec2(ep.x + e.size.x, ep.y)) then
		return true
	end
	return false 

end