---
-- Created by IntelliJ IDEA.
-- User: ZenX2
-- Date: 11/19/11
-- Time: 2:45 PM
--

newhandler("lua",
function(data)

	local f = loadstring(data[1])
	local s, e = pcall(f)
	if s == false and e~= nil then error(e) end

end)