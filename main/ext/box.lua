class.Box()

function Box:__init(t)

	self.name = t
	self.con = {}
	self.run = true
	self.Parse = function() end

end

function Box:Add(t) --add a line of content

	if not (#t > 50) then

		table.insert(self.con, t)

	else

		local e = string.Explode(" ", t)
		local s = 0
		local st = ""
		for k, v in pairs(e) do

			if v ~= "\n" then
			
				if #v + s + 1 > 50 then
					table.insert(self.con, st)
					st = ""
					s = 0
				end

				st = st..v.." "
				s = s + #v + 1
				
			else
			
				table.insert(self.con, st)
				st = ""
				s = 0
			
			end

		end
		if st ~= "" then table.insert(self.con, st) end

	end

end

function Box:Width()

	local w = 0
	for k, v in pairs(self.con) do

		if #v > w then w = #v end

	end
	if w > 50 then w = 50 end
	return w

end

function Box:Sep()

	io.write(" +"..string.rep("-", self:Width()).."+\n")

end

function Box:Draw()

	Clear()
	io.write(" /"..string.rep("=", self:Width()).."\\\n")
	io.write(" |"..self.name..string.rep(" ", self:Width() - #self.name).."|\n")
	self:Sep()
	for k, v in pairs(self.con) do

		io.write(" |"..v..string.rep(" ", self:Width() - #v).."|\n")

	end
	io.write(" \\"..string.rep("=", self:Width()).."/\n\n")

end

function Box:Start()

	self:Draw()
	
	while self.run do

		self:Parse(io.read())

	end

end

function Box:Stop()

	self.run = false
	self = nil

end
