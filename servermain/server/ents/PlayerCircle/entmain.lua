---
-- Created by IntelliJ IDEA.
-- User: ZenX2
-- Date: 11/24/11
-- Time: 10:58 AM
--

class.PlayerCircle(NetBase)

function PlayerCircle:__init(ci)

	NetBase.__init(self)

	self.pos = Vec2(30, 30)
	self.ci = ci
	self.col = {math.random(0, 255), math.random(0, 255), math.random(0, 255), 255 }

	self.df = PlayerCircle.df

end

PlayerCircle.df = love.filesystem.read("server/ents/PlayerCircle/draw.lua")

function PlayerCircle:Update(dt)

	local c = GetClient(self.ci)

	if c:KeyIsDown("w") then

		self.pos = self.pos + Vec2(0, -dt * 100)

	end

	if c:KeyIsDown("s") then

		self.pos = self.pos + Vec2(0, dt * 100)

	end

	if c:KeyIsDown("a") then

		self.pos = self.pos + Vec2(-dt * 100, 0)

	end

	if c:KeyIsDown("d") then

		self.pos = self.pos + Vec2(dt * 100, 0)

	end

end

function PlayerCircle:Disconnect(ci)

	if ci == self.ci then

		self:Remove()

	end

end