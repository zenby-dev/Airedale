---
-- Created by IntelliJ IDEA.
-- User: ZenX2
-- Date: 11/18/11
-- Time: 11:20 PM
--

function send(tag, data, client)

	local d = tabletostring(data) --separate all data
	SERVER:send(tag.."\1"..d, client)

end
