class.Vec2()

function Vec2:__init(x, y)

	self.x = x or 0
	self.y = y or 0

end

function Vec2:Distance(v)

	return math.sqrt((v.x - self.x)^2 + (v.y - self.y)^2)

end

function Vec2:__add(b)

	return Vec2(self.x + b.x, self.y + b.y)

end

function Vec2:__sub(b)

	return Vec2(self.x - b.x, self.y - b.y)

end

function Vec2:__mul(b)

	return Vec2(self.x * b, self.y * b)

end

function Vec2:__div(b)

	return Vec2(self.x / b, self.y / b)

end

function Vec2:__eq(b)

	if self.x == b.x and self.y == b.y then return true end
	return false

end

function Vec2:__tostring()

	return self.x.." "..self.y

end

function Vec2:Length()

	return self:Distance(Vec2())

end

function Vec2:Rotate(a)

	return Vec2(self.x*math.cos(a)-self.y*math.sin(a),self.x*math.sin(a)+self.y*math.cos(a))

end

function Vec2:Perp()

	return Vec2(-self.y, self.x)

end

function Vec2:Dist()

	return math.sqrt(self.x * self.x + self.y * self.y)

end

function Vec2:Norm()

	local d = self:Dist()
	return Vec2(self.x/d, self.y/d)

end

function Vec2:BreshLine(b)

	local x1, y1, x2, y2 = self.x, self.y, b.x, b.y
	local function swap(a, b) return b, a end
	local pts = {}
	local function plot(a, b) table.insert(pts, Vec2(a, b)) end
	local steep = math.abs(y2 - y1) > math.abs(x2 - x1)
	if steep then 
		x1, y1 = swap(x1, y1)
		x2, y2 = swap(x2, y2)
	end
	if x1 > x2 then
		x1, x2 = swap(x1, x2)
		y1, y2 = swap(y1, y2)
	end
	local dx, dy = x2 - x1, math.abs(y2 - y1)
	local e = dx / 2
	local ys = -1
	local y = y1
	if y1 < y2 then ys = 1 end
	for x = x1, x2 do
		if steep then plot(y,x) else plot(x, y) end
		e = e - dy
		if e < 0 then
			y = y + ys
			e = e + dx
		end
	end
	return pts

end

function Vec2:WuLine(v)

	local function fpart(x) return x - math.floor(x) end
	local function rfpart(x) return 1 - fpart(x) end
	local function swap(a, b) return b, a end
	local pts = {}
	local function plot(a, b) table.insert(pts, Vec2(a, b)) end
	local x1, y1, x2, y2 = self.x, self.y, v.x, v.y
	local dx, dy = x2 - x1, y2 - y1
	if math.abs(dx) < math.abs(dy) then
		x1, y1 = swap(x1, y1)
		x2, y2 = swap(x2, y2)
		dx, dy = swap(dx, dy)
	end
	if x2 < x1 then
		x1, x2 = swap(x1, x2)
		y1, y2 = swap(y1, y2)
	end
	local grad = dy / dx
	local xend = math.Round(x1)
	local yend = y1 + grad * (xend - x1)
	local xgap = fpart(x1 + 0.5)
	local xpxl1 = xend
	local ypxl1 = math.floor(yend)
	plot(xpxl1, ypxl1)
	plot(xpxl1, ypxl1 + 1)
	local intery = yend + grad
	
	local xend = math.Round(x2)
	local yend = y2 + grad * (xend - x2)
	local xgap = fpart(x2 + 0.5)
	local xpxl2 = xend
	local ypxl2 = math.floor(yend)
	plot(xpxl2, ypxl2)
	plot(xpxl2, ypxl2 + 1)
	
	for x = xpxl1 + 1, xpxl2 - 1 do
	
		plot(x, math.floor(intery))
		plot(x, math.floor(intery) + 1)
		intery = intery + grad
	
	end
	return pts

end

function Vec2:BreshCirc(r)

	local pts = {}
	
	local function p4p(cx, cy, x, y)

		local function plot(a, b) table.insert(pts, Vec2(a, b)) end
		plot(cx + x, cy + y)
		if x ~= 0 then plot(cx - x, cy + y) end
		if y ~= 0 then plot(cx + x, cy - y) end
		if x ~= 0 and y ~= 0 then plot(cx - x, cy - y) end
		
	end
	
	local function p8p(cx, cy, x, y)

		p4p(cx, cy, x, y)
		if x ~= y then p4p(cx, cy, y, x) end

	end
	
	local cx, cy = self.x, self.y
	local e = -r
	local x = r
	local y = 0
	while x >= y do
		p8p(cx, cy, x, y)
		e = e + y
		y = y + 1
		e = e + y
		if e >= 0 then
			x = x - 1
			e = e - x
			e = e - x
		end
	end
	
	return pts

end

function Vec2:BreshCircR(r)

	local pts = {}
	for i = 1, r do
		for k, v in pairs(self:BreshCirc(i)) do
			table.insert(pts, v)
		end
	end
	return pts
	
end

function table.HasValue( t, val )
	for k,v in pairs(t) do
		if (v == val ) then return true end
	end
	return false
end

function Vec2:FloodFind(b)

	local pts = {}
	local function flood(v)
	
		if table.HasValue(b, v) or table.HasValue(pts, v) or not v:InGrid() then return end
		table.insert(pts, v)
		flood(Vec2(v.x + 1, v.y))
		flood(Vec2(v.x - 1, v.y))
		flood(Vec2(v.x, v.y + 1))
		flood(Vec2(v.x, v.y - 1))
		return
	
	end
	flood(self)
	return pts

end