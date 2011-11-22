require"mods/platformerphysics/platent"
class.PlatformerWorld()

function PlatformerWorld:__init(gx, gy)

	self.grav = Vec2(gx, gy)
	self.ents = {}

end

PlatformerWorld.AirFriction = 100
PlatformerWorld.FrictionCo = 1

function PlatformerWorld:UpdateEnts(dt)

	for k, v in pairs(self.ents) do
		
		local ov = v.vel
		
		v.vel = v.vel + v.acc * dt
		
		for _, e in pairs(self.ents) do
			
			--(v:Collides(np, e, e.pos) or e:Collides(e.pos, v, np))
			if e.__entindex ~= v.__entindex then
				local xnp = v.pos + Vec2((v.vel).x, 0)
				local ynp = v.pos + Vec2(0, (v.vel).y)
				if (v.vel.x > 0 or v.vel.x < 0) and (v:Collides(xnp, e, e.pos) or e:Collides(e.pos, v, xnp)) then --moving left/right
					if e.mass ~= 0 then e:ApplyForce(Vec2(v.vel.x, 0)) end
					v.vel.x = 0
				end
				if (v.vel.y > 0 or v.vel.y < 0) and (v:Collides(ynp, e, e.pos) or e:Collides(e.pos, v, ynp)) then --up/down
					local f = (-v.vel.x * (v.friction * e.friction)) * self.FrictionCo
					v.vel.x = v.vel.x + f
					if e.mass ~= 0 then e:ApplyForce(Vec2(0, v.vel.y) * (v.mass * e.mass)) end
					v.vel.y = 0
				end
			end
			
			v.pos = v.pos + v.vel * dt
			
		end
		
		v.acc = Vec2()
		
		if v.gravity then
			v:ApplyAcc(self.grav * (v.mass * dt))
		end
	
	end

end

function Vec2:ToGrid()

	return Vec2(math.floor(self.x / 32), math.floor(self.y / 32))

end

function PlatformerWorld:Update(dt)

	if not world then return end
	
	world:UpdateEnts(dt)
	
	for k, v in pairs(world.ents) do
	
		if v.img then
		
			v.img.p = v.pos
		
		end
	
	end

end