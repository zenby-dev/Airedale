class.View()

function View:__init(pos)
	self.pos = pos or Vec2(1, 1) 
end

function View:Translate(t)
	self.pos = self.pos + t
end

function View:SetPos(p)

	self.pos = p

end

function View:Pos()

	return self.pos

end

function View:LX()

	return self.pos.x

end

function View:RX()

	return self.pos.x + vw

end

function View:TY()

	return self.pos.y

end

function View:BY()

	return self.pos.y + vh

end

function View:Bounds() --left, right, top, bottom

	return self:LX(), self:RX(), self:TY(), self:BY()

end

function View:Within(p)

	local l, r, t, b = self:Bounds()
	if p.x < l and p.x > r and p.y < t and p.y > b then return true end
	return false

end

function View:Far() --returns the bottom right corner's pos

	return Vec2(self.pos.x + vw, self.pos.y + vh)

end