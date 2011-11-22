function string.ToTable ( str )

	local tab = {}
	
	for i=1, string.len( str ) do
		table.insert( tab, string.sub( str, i, i ) )
	end
	
	return tab

end

function string.Explode ( seperator, str )

	if ( seperator == "" ) then
		return string.ToTable( str )
	end

	local tble={}	
	local ll=0
	
	while (true) do
	
		l = string.find( str, seperator, ll, true )
		
		if (l ~= nil) then
			table.insert(tble, string.sub(str,ll,l-1)) 
			ll=l+1
		else
			table.insert(tble, string.sub(str,ll))
			break
		end
		
	end
	
	return tble
	
end

function string.Implode(seperator,Table) return 
	table.concat(Table,seperator) 
end

function string.GetExtensionFromFilename(path)
	local ExplTable = string.ToTable( path )
	for i = table.getn(ExplTable), 1, -1 do
		if ExplTable[i] == "." then return string.sub(path, i+1)end
		if ExplTable[i] == "/" or ExplTable[i] == "\\" then return "" end
	end
	return ""
end

function string.GetPathFromFilename(path)
	local ExplTable = string.ToTable( path )
	for i = table.getn(ExplTable), 1, -1 do
		if ExplTable[i] == "/" or ExplTable[i] == "\\" then return string.sub(path, 1, i) end
	end
	return ""
end

function string.GetFileFromFilename(path)
	local ExplTable = string.ToTable( path )
	for i = table.getn(ExplTable), 1, -1 do
		if ExplTable[i] == "/" or ExplTable[i] == "\\" then return string.sub(path, i) end
	end
	return ""
end

function string.Left(str, num)
	return string.sub(str, 1, num)
end

function string.Right(str, num)
	return string.sub(str, -num)
end



function string.Replace(str, tofind, toreplace)
	local start = 1
	while (true) do
		local pos = string.find(str, tofind, start, true)
	
		if (pos == nil) then
			break
		end
		
		local left = string.sub(str, 1, pos-1)
		local right = string.sub(str, pos + #tofind)
		
		str = left .. toreplace .. right
		start = pos + #toreplace
	end
	return str
end

function string.Trim( s, char )
	if (char==nil) then char = "%s" end
	return string.gsub(s, "^".. char.."*(.-)"..char.."*$", "%1")
end

function string.TrimRight( s, char )
	
	if (char==nil) then char = " " end	
	
	if ( string.sub( s, -1 ) == char ) then
		s = string.sub( s, 0, -2 )
		s = string.TrimRight( s, char )
	end
	
	return s
	
end

function string.TrimLeft( s, char )

	if (char==nil) then char = " " end	
	
	if ( string.sub( s, 1 ) == char ) then
		s = string.sub( s, 1 )
		s = string.TrimLeft( s, char )
	end
	
	return s

end

function Tab(n)

	local r = ""
	for i = 1, n do r = r.."    " end
	return r

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