---
-- Created by IntelliJ IDEA.
-- User: ZenX2
-- Date: 11/20/11
-- Time: 11:08 PM
--

newhandler("sendlua",
function(data)
	
	local s, e = pcall(loadstring(data[1]))
	if not s then error(e) end

end)
