class.Vector()

function Vector:__init(x, y, z)

	self.x = x or 0
	self.y = y or 0
	self.z = z or 0

end

Vector.__type = "vector"

function Vector:Distance(v)

	return math.sqrt((v.x - self.x)^2 + (v.y - self.y)^2 + (v.z - self.z)^2)

end

function Vector:__add(b)

	return Vector(self.x + b.x, self.y + b.y, self.z + b.z)

end

function Vector:__sub(b)

	return Vector(self.x - b.x, self.y - b.y, self.z - b.z)

end

function Vector:__mul(b)

	return Vector(self.x * b, self.y * b, self.z * b)

end

function Vector:__div(b)

	return Vector(self.x / b, self.y / b, self.z / b)

end

function Vector:__eq(b)

	if self.x == b.x and self.y == b.y and self.z == b.z then return true end
	return false

end

function Vector:__tostring()

	return self.x.." "..self.y.." "..self.z

end

function Vector:Length()

	return self:Distance(Vector())

end

function Vector:Average(v2, v3)

	return Vector((self.x+v2.x+v3.x)/3, (self.y+v2.y+v3.y)/3, (self.z+v2.z+v3.z)/3)

end

function Vector:Mag()

	return math.sqrt((self.x^2)+(self.y^2)+(self.z^2))

end

function Vector:To2D(scale)
	return Vec2(self.x*(scale/math.abs(self.z)),self.y*(scale/math.abs(self.z)))
end

function Vector:Rotate(a1, a2)

	local s1=math.sin(a1)
	local s2=math.sin(a2)
	local c1=math.cos(a1)
	local c2=math.cos(a2)
	return Vector(c1+s1+1,1+c2-s2,-s1+c1+s2+c2)

end

function Vector:Dot(v)

	return self.x*v.x+self.y*v.y+self.z*v.z

end

function Vector:Norm()

	local d = self:Mag()
	return Vector(self.x/d,self.y/d,self.z/d)

end

function Vector:Bounce(v)

	local nv = self:Norm()
	local dp = nv:Dot(v)
	return Vector(2*nv.x*dp,2*nv.y*dp,2*nv.z*dp)

end

function Vector:Light(c)

	local cv = c:Norm()
	local v = self:Bounce(cv)
	local d = v:Rotate(-c.ang.p,-c.ang.y):Mag()
	local l = 255
	if d > math.sqrt(2) then
		l = 0
	end
	l = l - d * 127 --127 is a good number, right?
	return l

end

function Vector:Perp(v2, v3)

	local u = Vector(v2.x-self.x, v2.y-self.y, v2.z-self.z)
	local v = Vector(v3.x-self.x, v3.y-self.y, v3.z-self.z)
	return Vector(
		u.y*v.z-u.z*v.y,
		u.z*v.x-u.x*v.z,
		u.x*v.y-u.y*v.x
		):Norm()

end

function Vector:Format(c)

	local x,y,z = self.x, self.y, self.z
	x = x - c.pos.x
	y = y - c.pos.y
	z = z - c.pos.z
	local v = Vec2(x, z):Rotate(c.ang.y)
	return Vector(v.x,y,v.y)

end