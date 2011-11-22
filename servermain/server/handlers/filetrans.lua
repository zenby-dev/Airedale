---
-- Created by IntelliJ IDEA.
-- User: ZenX2
-- Date: 11/20/11
-- Time: 7:19 PM
--

FT = {}

function FT.FromClient(path, ci)

	send("ft.fc", {path}, ci) --send file transfer request

end

newhandler("ft.fc",
function(data, ci)

	love.filesystem.write(data[1], data[2])
	print("[FT] Transferred '"..data[1].."' from client "..ci.." successfully")

end)

newhandler("ft.fs",
function(data, ci)
	
	if love.filesystem.exists(data[1]) then

		send("ft.fs", {data[1], love.filesystem.read(data[1])}, ci)

	end

end)
