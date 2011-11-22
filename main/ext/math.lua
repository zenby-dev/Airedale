function math.lerp(c, a, b)
    c = math.Min(1,math.Max(c,0))
    return a + (b - a) * c
end

function math.average(a, b)

	return (a + b) / 2

end

function math.averaget(t)

	local num = 0
	for k, v in pairs(t) do
	
		num = num + v
	
	end
	
	return num / #t

end

function math.Round( i )
	i = i or 0
	return math.floor( i + 0.5 )
end

function math.Clamp( _in, low, high )
	if (_in < low ) then return low end
	if (_in > high ) then return high end
	return _in
end

function math.Max( a, b )
	if ( a > b ) then return a end
	return b
end

function math.Min( a, b )
	if ( a > b ) then return b end
	return a
end

function math.AddSeries(n)

	local nu = 0
	for i = 1, n do
	
		nu = nu + i
	
	end
	return nu

end

function math.Variance(n)

	return math.random(math.Round(-n / 4), math.Round(n / 4))

end

--[[local oldrandom = math.random

function math.random(n1, n2)

	oldrandom() oldrandom() oldrandom()
	oldrandom(n1, n2)

end]]