---
-- Created by IntelliJ IDEA.
-- User: ZenX2
-- Date: 11/19/11
-- Time: 9:40 PM
--

newhandler("vfscopy",
function(data, ci)

	send("vfscopy", {data[1], tabletostring(vfs.dir(data[1]))}, ci)

end)
