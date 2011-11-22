class.ListElem()

function ListElem:__init(tab)
	self.list = tab or {}
	self.__listindex = #self.list + 1
	self.list[self.__listindex] = self
end

function ListElem:Remove()

	self.list[self.__listindex] = nil

end