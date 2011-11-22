class.DataPacket()

function DataPacket:__init(k, ...)

	self.key = k
	if #{...} == 1 then
		self.con = ...
	end
	self.con = {...}

end

function DataPacket:Insert(v)

	table.insert(self.con, v)

end

function DataPacket:ToTable()
	local tab = {}
	
	if type(self) ~= "table" then return self.con end
	
	for k, v in pairs(self.con) do
	
		if type(v) == "table" and v.instance_of and v:instance_of(DataPacket) then v = v:ToTable() end
			
		table.insert(tab, v)
	
	end
	
	return tab
end