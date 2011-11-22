---
-- Created by IntelliJ IDEA.
-- User: ZenX2
-- Date: 11/19/11
-- Time: 2:49 PM
--

newhandler("chat",
function(data, clientid)

	local c = CLIENTS[clientid]
	print(c.name.." ("..tostring(clientid).."): "..tostring(data[1]))
	send("print", {c.name..": "..tostring(data[1])})

end)
