function table.Random(t)

	local r = math.random(1, #t)
	return t[r], r

end

function table.size(t)

	local n = 0
	for k, v in pairs(t) do
	
		n = n + 1
	
	end
	return n

end

function table.average(t)

	local n = 0
	for k, v in pairs(t) do
	
		n = n + v
	
	end
	n = n / table.size(t)
	return n

end

function table.Copy(t, lookup_table)
	if (t == nil) then return nil end
	
	local copy = {}
	setmetatable(copy, getmetatable(t))
	for i,v in pairs(t) do
		if type(v) ~= "table" then
			copy[i] = v
		else
			lookup_table = lookup_table or {}
			lookup_table[t] = copy
			if lookup_table[v] then
				copy[i] = lookup_table[v] -- we already copied this table. reuse the copy.
			else
				copy[i] = table.Copy(v,lookup_table) -- not yet copied. copy it.
			end
		end
	end
	return copy
end