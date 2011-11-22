---
-- Created by IntelliJ IDEA.
-- User: ZenX2
-- Date: 11/19/11
-- Time: 2:49 PM
--

newhandler("chat",
function(data, clientid)

	print(tostring(clientid)..": "..tostring(data[1]))
	send("print", {tostring(clientid)..": "..tostring(data[1])})

end)
