class.Ent()

function Ent:__init(tab)
	self.__entindex = #ents + 1
	ents[self.__entindex] = self
end

function Ent:Remove()

	ents[self.__entindex] = nil

end