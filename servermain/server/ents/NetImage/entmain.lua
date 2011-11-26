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
	self.ext = (ext or {})

end

NetImage.df = love.filesystem.read("server/ents/NetImage/draw.lua")

function NetImage:Update(dt)

	

end

function NetImage:Disconnect(ci)

	
	
end