---
-- Created by IntelliJ IDEA.
-- User: ZenX2
-- Date: 11/17/11
-- Time: 9:42 PM
--

class.NetBase(Ent)

function NetBase:__init(indx)

	if indx then
		self.__entindex = indx
		ents[self.__entindex] = self
	end

end

function NetBase:Draw()

	local s, e = pcall(function() loadstring(self.df)()(self) end)
	if not s then error(e) end

end

function NetBase:Update(dt)

	if self.ext and not self.img then

		self.img = Image(self.path, self.pos)

	end

	if self.ext and self.img then

		for k, v in pairs(self.ext) do

			self.img[k] = v

		end

	end

end

newhandler("entsync",
function(data)

	--if not data then return end
	if not ents[data[2].__entindex] then --initialize if it's not here

		NetBase(data[2].__entindex)
		for k, v in pairs(data[2]) do

			ents[data[2].__entindex][k] = v

		end

	else

		for k, v in pairs(data[2]) do

			ents[data[2].__entindex][k] = v

		end

	end

end)

newhandler("entremove",
function(data)

	ents[data[1]]:Remove()

end)