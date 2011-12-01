---
-- Created by IntelliJ IDEA.
-- User: ZenX2
-- Date: 12/1/11
-- Time: 12:01 AM
--

newhandler("confirmclientconnection",
function(data)

	CONNECTED = true
	CONNECTION = PENDINGCONNECTION
	PENDINGCONNECTION = nil
	print("[NET] Connection to "..CONNECTION.." successful")

	Menu.Clear()
	Menu.Open = false
	Menu.OnMainMenu = false

	print("[NET] Sending user info")

	send("userinfo", {CONFIG.Username})

end)
