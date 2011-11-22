class.Image()

Images = {}
images = {}

function Image:__init(f, p)
	if not images[f] then
		images[f] = love.graphics.newImage(f)
	end
	self.i = images[f]
	self.i:setFilter("nearest", "nearest")
	self.ss = Vec2(0, 0)
	self.anim = Vec2(0, 0)
	self.ori = Vec2(0, 0)
	self.scale = Vec2(1, 1)
	self.q = love.graphics.newQuad(0, 0, self.i:getWidth(), self.i:getHeight(), self.i:getWidth(), self.i:getHeight())
	self.p = p or Vec2(0, 0)
	self.a = 0
	self.__imgindex = #Images + 1
	Images[self.__imgindex] = self
end

function Image:SetSS(p)

	self.ss = p

end

function Image:SetAnim(p)

	self.anim = p
	self.q = love.graphics.newQuad(p.x, p.y, self.ss.x, self.ss.y, self.i:getWidth(), self.i:getHeight())

end

function Image:SetPos(p)

	self.p = p

end

function Image:SetOrigin(p)

	self.ori = p

end

function Image:SetScale(p)

	self.scale = p

end

function Image:SetRotation(a)

	self.a = a

end

function Image:AddRotation(a)

	self.a = self.a + a
	if self.a > math.pi * 2 then
		self.a = self.a - math.pi * 2
		self:AddRotation(0)
	elseif self.a < 0 then
		self.a = self.a + math.pi * 2
		self:AddRotation(0)
	end

end

function Image:Draw()
	local p = self.p or Vec2(0, 0)
	love.graphics.drawq(self.i, self.q, p.x, p.y, self.a, self.scale.x, self.scale.y, self.ori.x, self.ori.y)
end

function Image:Remove()

	Images[self.__imgindex] = nil

end

class.ImageFD(Image)

function ImageFD:__init(d, p)
	self.i = love.graphics.newImage(d)
	self.i:setFilter("nearest", "nearest")
	self.ss = Vec2(0, 0)
	self.anim = Vec2(0, 0)
	self.ori = Vec2(0, 0)
	self.scale = Vec2(1, 1)
	self.q = love.graphics.newQuad(0, 0, self.i:getWidth(), self.i:getHeight(), self.i:getWidth(), self.i:getHeight())
	self.p = p
	self.a = 0
	self.__imgindex = #Images + 1
	Images[self.__imgindex] = self
end