local function poss(p)

	local pos = p:split(",")
	return Vec2(pos[1], pos[2])

end

function LoadSpriteFromXML(path) --This makes everything INSANELY easy, just define the specifications of a sprite in an XML file, load it up.

	local text = love.filesystem.read(path, all)
	local xml = XML.Collect(text)
	
	local dyn = DynSprite()
	
	for k, v in pairs(xml) do
	
		if v.label == "sprite" then
		
			local args = v.xarg
			dyn:SetPos(poss(args.pos))
			for k1, v1 in pairs(v) do
			
				if k1 ~= "xarg" and k1 ~= "label" then
				
					local frames = {}
					
					for k2, v2 in pairs(v1) do
					
						if k2 ~= "xarg" and k2 ~= "label" then
						
							local i = Image(args.file)
							i:SetOrigin(poss(v2.xarg.origin))
							i:SetSS(poss(v2.xarg.ss))
							i:SetAnim(poss(v2.xarg.anim))
							if v2.xarg.wep then
								i.wepoff = poss(v2.xarg.wep)
							end
							table.insert(frames, i)
						
						end
					
					end
					
					local a = Animation(poss(args.pos), frames)
					a:SetSpeed(tonumber(v1.xarg.speed))
					dyn:AddAnim(v1.xarg.name, a)
				
				end
			
			end
		
		end
	
	end
	
	return dyn

end

function string:split(delimiter)
	local result = {}
	local from  = 1
	local delim_from, delim_to = string.find( self, delimiter, from  )
	while delim_from do
		table.insert( result, string.sub( self, from , delim_from-1 ) )
		from  = delim_to + 1
		delim_from, delim_to = string.find( self, delimiter, from  )
	end
	table.insert( result, string.sub( self, from  ) )
	return result
end