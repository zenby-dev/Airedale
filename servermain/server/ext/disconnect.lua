---
-- Created by IntelliJ IDEA.
-- User: ZenX2
-- Date: 11/19/11
-- Time: 5:41 PM
--

function disconnect(reason, ci)

	send("disconnect", {reason}, ci)
	if ci then
		if SERVER.callbacks.disconnect then
			SERVER.callbacks.disconnect(ci)
		end
		SERVER.clients[ci] = nil
	else
		if SERVER.callbacks.disconnect then
			for k, v in pairs(SERVER.clients) do
				SERVER.callbacks.disconnect(k)
			end
		end
		SERVER.clients = {}
	end

end