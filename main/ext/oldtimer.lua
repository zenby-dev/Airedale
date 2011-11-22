--[[timer = {} --Old Timer...
simpletimers = {}

function checktimers()

	local ct = os.clock()
	for k, v in pairs(simpletimers) do
	
		if v[1] < ct then
			v[2]()
			table.remove(simpletimers, k)
		end
	
	end

end

function timer.Simple(t, f)

	table.insert(simpletimers, {os.clock() + t, f})

end]]