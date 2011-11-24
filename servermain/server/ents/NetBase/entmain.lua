---
-- Created by IntelliJ IDEA.
-- User: ZenX2
-- Date: 11/17/11
-- Time: 9:42 PM
--

class.NetBase(Ent)

function NetBase:__init()

	self.pos = Vec2(0, 0)
	self.df = NetBase.df

	Ent.__init(self)

end

NetBase.df = love.filesystem.read("server/ents/NetBase/draw.lua")

function NetBase:Update(dt)

	

end

function NetBase:Remove()

	send("entremove", {self.__entindex})
	Ent.Remove(self)

end

function NetBase:Disconnect(ci)

	
	
end