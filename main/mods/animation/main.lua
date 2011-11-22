include("mods/animation/spriteloader.lua")

class.Animation() --my beautiful animation and sprite classes. they actually work!

function Animation:__init(pos, frames)

	self.pos = pos
	self.rotation = 0
	self.frames = frames
	self.speed = .1
	self.frame = 1
	self.framet = 0

end

function Animation:SetPos(p)

	self.pos = p

end

function Animation:SetRotation(r)

	self.rotation = r

end

function Animation:SetSpeed(s)

	self.speed = s

end

function Animation:Reset()

	self.frame = 1
	self.framet = 0

end

function Animation:Update(dt)

	self.framet = self.framet + dt
	if self.framet > self.speed then
		self.frame = self.frame + 1
		self.framet = 0
	end
	
	if self.frame > #self.frames then
		self.frame = 1
	end
	
	for k, v in pairs(self.frames) do
	
		v:SetPos(self.pos)
		v:SetRotation(self.rotation)
	
	end

end

function Animation:CurFrame()

	return self.frames[self.frame]

end

function Animation:Draw()

	self.frames[self.frame]:Draw()

end

class.DynSprite()

function DynSprite:__init(p)

	self.pos = p
	self.rotation = 0
	self.anims = {}
	self.anim = ""

end

function DynSprite:SetPos(p)

	self.pos = p

end

function DynSprite:SetRotation(r)

	self.rotation = r

end

function DynSprite:CurAnim()

	if not self.anims[self.anim] then return end
	return self.anims[self.anim]

end

function DynSprite:AddAnim(n, a)

	self.anims[n] = a

end

function DynSprite:SetAnim(n)

	self.anim = n
	self.anims[self.anim]:Reset()

end

function DynSprite:Draw()

	self.anims[self.anim]:Draw()

end

function DynSprite:Update(dt)

	self.anims[self.anim]:SetPos(self.pos)
	self.anims[self.anim]:SetRotation(self.rotation)
	self.anims[self.anim]:Update(dt)

end