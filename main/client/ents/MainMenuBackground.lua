---
-- Created by IntelliJ IDEA.
-- User: ZenX2
-- Date: 12/11/11
-- Time: 9:14 PM
--

class.MainMenuBackground()

function MainMenuBackground:__init()

	self.dist = 50
	self.img = Image("client/sprites/airedalemap.png", Vec2(0, 0))
	self.img.scale = Vec2(7, 7)
	local pos = self.img:GetSize() / -1.5
	self.img:SetPos(pos)
	self.startpos = pos
	self.pos = Vec2(0, 0)

end

function MainMenuBackground:Update(dt)

	local bx, by = self.startpos.x + self.img:GetSize().x / 1.1, self.img:GetSize().y / 6
	local speed = CONFIG.MainMenuSpeed or 1
	self.pos = Vec2(bx + (math.sin(os.clock() / (8 / speed)) * (self.img:GetSize().x / 3.5)) - (math.cos(os.clock() / (10 / speed)) * (self.img:GetSize().x / 10)) + self.img:GetSize().x / 5, by + (math.sin(os.clock() / (6 / speed)) * (self.img:GetSize().y / 6)) + self.img:GetSize().y / 6)
	--self.img:SetPos(Vec2(self.startpos.x + (math.sin(os.clock() / 2) * (self.img:GetSize().x / 10)), self.startpos.y + math.cos(os.clock() / 4) * 300))

end

function MainMenuBackground:Draw()

	local g = love.graphics

	g.push()
	g.translate(self.pos.x, self.pos.y)
	self.img:Draw()
	g.pop()

end

function MainMenuBackground:Remove()

	self.img:Remove()
	MMB = nil

end