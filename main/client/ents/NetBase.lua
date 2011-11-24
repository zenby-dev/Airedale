---
-- Created by IntelliJ IDEA.
-- User: ZenX2
-- Date: 11/17/11
-- Time: 9:42 PM
--

class.NetBase(Ent)

function NetBase:__init(pos, df, indx)

	self.pos = pos
	self.df = df

	if indx then
		self.__entindex = indx
		ents[self.__entindex] = self
	end

end

function NetBase:Draw()

	local s, e = pcall(function() loadstring("return "..self.df)()(self) end)
	if not s then error(e) end

end

function NetBase:Update(dt)

	

end

newhandler("entsync",
function(data)

	if data[1] == "create" then

		local indx
		if data[4] then indx = data[4] end
		NetBase(data[2], data[3], indx)

	end

end)