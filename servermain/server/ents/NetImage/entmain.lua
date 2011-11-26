---
-- Created by IntelliJ IDEA.
-- User: ZenX2
-- Date: 11/17/11
-- Time: 9:42 PM
--

class.NetImage(NetBase)

function NetImage:__init(path, pos, ext)

	NetBase.__init(self)

	self.pos = pos
	self.df = NetImage.df
	self.path = path
	self.ext = (ext or {})

end

NetImage.df = love.filesystem.read("server/ents/NetImage/draw.lua")

function NetImage:Update(dt)

	self.ext.pos = self.pos

end

function NetImage:Disconnect(ci)

	

end


function Image:SetSS(p)

	self.ext.ss = p

end

function Image:SetAnim(p)

	self.ext.anim = p

end

function Image:SetPos(p)

	self.ext.p = p

end

function Image:SetOrigin(p)

	self.ext.ori = p

end

function Image:SetScale(p)

	self.ext.scale = p

end

function Image:SetRotation(a)

	self.ext.a = a

end

function Image:AddRotation(a)

	self.ext.a = (self.ext.a + a) % (math.pi * 2)

end