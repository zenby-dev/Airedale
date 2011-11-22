class.ParticleSys()

ParticleSystems = {}

function ParticleSys:__init(p, img, max)

	self.pos = p
	self.img = img
	self.max = max
	self.sys = love.graphics.newParticleSystem(img.i, max)
	self.__pindex = #ParticleSystems + 1
	ParticleSystems[self.__pindex] = self

end

function ParticleSys:SetPos(v)

	self.pos = v
	self.sys:setPosition(v.x, v.y)

end

function ParticleSys:GetPos()

	return self.pos

end

function ParticleSys:Start()

	self.sys:start()

end

function ParticleSys:Stop()

	self.sys:stop()

end

function ParticleSys:Reset()

	self.sys:reset()

end

function ParticleSys:SetImage(i)

	self.img = i
	self.sys:setSprite(i.i)

end

function ParticleSys:Remove()

	self:Stop()
	self:Reset()
	ParticleSystems[self.__pindex] = nil

end

function ParticleSys.Update()

	for k, v in pairs(ParticleSystems) do
	
		v.sys:update()
	
	end

end
