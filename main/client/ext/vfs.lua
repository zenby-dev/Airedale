---
-- Created by IntelliJ IDEA.
-- User: ZenX2
-- Date: 11/19/11
-- Time: 7:54 PM
--

vfs = {}
vfs.archive = {["root"] = {}}
vfs.wd = "root"

function vfs.dir(d)

	local t = vfs.archive
	local f = d:split("/")
	for k, v in pairs(f) do

		if t[v] then

			t = t[v]

		else

			error("[vfs] Directory \""..d.."\" does not exist!")
			return --ABORT ABORT

		end

	end
	return t

end

function vfs.ls()

	print(vfs.wd.." contains:")
	for k, v in pairs(vfs.dir(vfs.wd)) do

		print(k)

	end

end

function vfs.cd(d)

	local f = vfs.dir(vfs.wd)
	if f[d] and vfs.IsDir(d) and d ~= ".." and d ~= "." then
		vfs.wd = vfs.wd.."/"..d
	elseif d == ".." then
		local nwd = ""
		local t = vfs.wd:split("/")
		for i = 1, #t - 1 do

			nwd = nwd..t[i]

		end
		vfs.wd = nwd
	elseif d == "." then
		--not much to do
	end

end

function vfs.Exists(path)

	local f = vfs.dir(vfs.wd.."/"..path)
	return (f ~= nil)

end

function vfs.IsDir(path)

	local f = vfs.dir(vfs.wd.."/"..path)
	return type(f) == "table"

end

function vfs.mkdir(d)

	local f = vfs.dir(vfs.wd)
	f[d] = {}

end

function vfs.Write(name, text)

	local f = vfs.dir(vfs.wd)
	f[name] = text --write to it!

end

function vfs.Read(path)

	local f = vfs.dir(vfs.wd)
	if f[path] then --is it a text file?

		return f[path] --read it!

	end

end

function vfs.Append(path, text)

	local f = vfs.dir(vfs.wd.."/"..path)
	if vfs.Exists(path) then
		vfs.Write(path, vfs.Read(path)..text)
	else
		vfs.Write(path, text)
	end

end

function vfs.Init()

	vfs.archive = {["root"] = {}} --root.
	vfs.wd = "root"
	--other stuff?

end

function vfs.CopyFromServer(path) --the path of the server vfs to be copied

	send("vfscopy", {path})

end

function vfs.RunLua(path)

	local s, e = pcall(loadstring(vfs.Read(path)))
	if not s then error(e) end

end

newhandler("vfscopy", --copying files from the server! (virtually)
function(data)

	local nt = loadtable(data[2])
	local t = vfs.archive
	local f = d[1]:split("/")
	for k, v in pairs(f) do

		if k == #f then

			t[v] = nt --?
			break

		end

		if t[v] then

			t = t[v]

		else

			error("[vfs] Directory \""..d[1].."\" does not exist!")
			return --ABORT ABORT

		end

	end


end)