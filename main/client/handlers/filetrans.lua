---
-- Created by IntelliJ IDEA.
-- User: ZenX2
-- Date: 11/20/11
-- Time: 4:58 PM
--

FT = {}

function FT.FromServer(path)

	send("cffs", {path}) --send file transfer request

end

newhandler("ft.fs",
function(data)

	love.filesystem.write(data[1], data[2])
	print("[FT] Transferred '"..data[1].."' from server successfully")

end)

newhandler("ft.fc",
function(data)

	if love.filesystem.exists(data[1]) then

		send("ft.fc", {data[1], love.filesystem.read(data[1])})

	end

end)