GUI.Box = class()

function GUI.Box:__init(x, y, w, h)

	self.pos = Vec2(x, y)
	self.size = Vec2(w, h)
	self.children = {}
	self.__drawindex = #GUI.Controls + 1
	GUI.Controls[self.__drawindex] = self
	

end

function GUI.Box:Draw()

	local p, s = self.pos, self.size
	SetColor(Color(0, 0, 0))
	love.graphics.rectangle("fill", p.x, p.y, s.x, s.y)
	SetColor(Color())
	love.graphics.rectangle("line", p.x, p.y, s.x, s.y)

end

function GUI.Box:Remove()

	for k, v in pairs(self.children) do --remove all children
		v:Remove()
	end
	GUI.Controls[self.__drawindex] = nil

end

function GUI.Box:SetParent(p)

	self.parent = p
	self.pos = self.pos + self.parent.pos
	table.insert(p.children, self)

end

function GUI.Box:SetPos(p)

	for k, v in pairs(self.children) do
		local vp, pp = v.pos, self.pos
		local offset = vp - pp
		v:SetPos(p + offset) 
	end
	self.pos = p

end

function GUI.Box:GetPos()

	return self.pos

end

function GUI.Box:SetSize(p)

	self.size = p

end