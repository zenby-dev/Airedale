class.Poly()

function Poly:__init(verts)

	self.verts = verts

end

function Poly:SetPos(p)

	local op = self.verts[1]
	local nt = {}
	for k, v in pairs(self.verts) do
	
		table.insert(nt, (v - op) + p)
	
	end
	self.verts = nt

end

function Poly:Colliding(poly)

	for k, v in pairs(poly.verts) do
	
		if self:ContainsPoint(v) then return true end
	
	end
	
	return false

end

function Poly:ContainsPoint(point)

	local i, j, c = 1, #self.verts, false
	while i < #self.verts do
	
		if (self.verts[i].y > point.y) ~= (self.verts[j].y > point.y) and point.x < (self.verts[j].x - self.verts[i].x) * (point.y - self.verts[i].y) / (self.verts[j].y - self.verts[i].y) + self.verts[i].x then
		
			c = not c
		
		end
		
		j = i
		i = i + 1
	
	end
	return c

end