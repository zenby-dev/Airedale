file = {}

function file.Write(p, t)

	local file, err = io.open(p, "w")
	if err then error(err) end
	file:write(tostring(t))
	file:close()

end

function file.Exists(p)

	local file, err = io.open(p, "r")
	if err and string.find(err, "No such file or directory") then return false end
	file:close()
	return true

end

function file.Read(p)

	if not file.Exists(p) then return "" end
	local file, err = io.open(p, "r")
	local r = file:read()
	file:close()
	return r

end

function file.Append(p, t)

	if not file.Exists(p) then file.Write(p, "") end
	file.Write(p, (file.Read(p) or "")..t)

end