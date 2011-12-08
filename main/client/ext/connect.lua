---
-- Created by IntelliJ IDEA.
-- User: ZenX2
-- Date: 11/18/11
-- Time: 10:51 PM
--

function connect(ipaport)

	print("[NET] Beginning connection to "..ipaport)
	if CONNECTED then

		print("[NET] Already connected to "..CONNECTION)
		disconnect()

	end

	local ip = ipaport:split(":")
	if ip[1] == "localhost" then ip[1] = "127.0.0.1" end
	local s, e = pcall(function() print("[NET] Initiating connection to "..ipaport) CLIENT:connect(ip[1], ip[2], false) end)
	if not s then error(e) print("[NET] Connection failed. See error above") return end

	print("[NET] Connection in progress to "..ipaport)
	PENDINGCONNECTION = ipaport

	GUI.AddText("connectingtext", "Connecting to server...", 20, 20)

	Menu.Clear()
	Menu.Open = false
	Menu.OnMainMenu = false

	timer.Create("WaitOnConnection", 20, 1, function()

		GUI.Remove("connectingtext")
		PENDINGCONNECTION = nil
		print("[NET] Cancelling connection. (Timeout)")
		Menu.Main()
		
	end) --give up after a while

	--Now to await confirmation

end

function cancelconnect()

	timer.Destroy("WaitOnConnection")
	GUI.Remove("connectingtext")
	PENDINGCONNECTION = nil
	print("[NET] Cancelling connection. (Cancel)")
	Menu.Main()

end

function disconnect(res)

	if res then print("Disconnected from server with reason: "..res) end
	CLIENT:disconnect()
	for k, v in pairs(ents) do

		v:Remove()

	end
	CONNECTED = false
	CONNECTION = nil
	PENDINGCONNECTION = nil

end