class.Ent()

Ents = {}

function Ent:__init()

	self.__state = GetState()
	if not Ents[self.__state] then Ents[self.__state] = {} end
	self.__entindex = #Ents[self.__state] + 1
	Ents[self.__state][self.__entindex] = self

end

function Ent:Update()



end

function Ent:Remove()

	--print(self.__state)
	--print(self.__entindex)
	Ents[self.__state][self.__entindex] = nil

end

function ClearEnts(s)

	if s then
		for k, v in pairs(Ents[s]) do

			v:Remove()

		end
	else
		for k, v in pairs(Ents) do

			for k2, v2 in pairs(v) do

				v2:Remove()

			end

		end
	end

end