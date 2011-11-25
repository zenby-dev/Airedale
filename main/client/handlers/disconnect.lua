---
-- Created by IntelliJ IDEA.
-- User: ZenX2
-- Date: 11/19/11
-- Time: 5:01 PM
--

newhandler("disconnect",
function(data)

	print("Disconnected from server with reason: "..data[1])
	CLIENT:disconnect()
	for k, v in pairs(ents) do

		v:Remove()

	end

end)