---
-- Created by IntelliJ IDEA.
-- User: ZenX2
-- Date: 12/1/11
-- Time: 12:01 AM
--

newhandler("confirmclientconnection",
function(data)

	if PENDINGCONNECTION == nil then print("[NET] Refusing connection confirmation. There is no pending connection.") return end

	GUI.Remove("connectingtext")
	timer.Destroy("WaitOnConnection")
	CONNECTED = true
	CONNECTION = PENDINGCONNECTION
	PENDINGCONNECTION = nil
	print("[NET] Connection to "..CONNECTION.." successful")

	print("[NET] Sending user info")

	send("userinfo", {CONFIG.Username})

end)
