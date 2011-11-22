class.Color()

function Color:__init(r, g, b, a)

	self.r = r or 255
	self.g = g or 255
	self.b = b or 255
	self.a = a or 255

end

function Color:__add(b)

	local c = math.Clamp
	return Color(c(self.r + b.r, 0, 255), c(self.g + b.g, 0, 255), c(self.b + b.b, 0, 255), c(self.a + b.a, 0, 255))

end

function Color:AddNoA(b, a)

	local c = math.Clamp
	return Color(c(self.r + b.r, 0, 255), c(self.g + b.g, 0, 255), c(self.b + b.b, 0, 255), a)

end

function Color:__tostring()

	return self.r.." "..self.g.." "..self.b.." "..self.a

end

function Color:Average(b)

	local a = math.average
	return Color(a(self.r, b.r), a(self.g, b.g), a(self.b, b.b), a(self.a, b.a))

end

function Color:Lerp(p, b)

	local a = math.lerp
	return Color(a(p, self.r, b.r), a(p, self.g, b.g), a(p, self.b, b.b), a(p, self.a, b.a))

end

function RandomColor()

	return Color(math.random(0, 255), math.random(0, 255), math.random(0, 255))

end

function RandomBW()

	if math.random(1, 2) == 1 then
		return Color()
	else
		return Color(0, 0, 0)
	end

end
