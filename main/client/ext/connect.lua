---
-- Created by IntelliJ IDEA.
-- User: ZenX2
-- Date: 11/18/11
-- Time: 10:51 PM
--

function connect(ipaport)

	if CONNECTED then

		disconnect()
		CONNECTED = false
		CONNECTION = nil

	end

	local ip = ipaport:split(":")
	if ip[1] == "localhost" then ip[1] = "127.0.0.1" end
	local s, e = pcall(function() CLIENT:connect(ip[1], ip[2], false) CONNECTED = true CONNECTION = ipaport end)
	if not s then error(e) end

	send("userinfo", {CONFIG.Username})

end

function disconnect(res)

	if res then print("Disconnected from server with reason: "..res) end
	CLIENT:disconnect()
	for k, v in pairs(ents) do

		v:Remove()

	end
	CONNECTED = false
	CONNECTION = nil

end