---
-- Created by IntelliJ IDEA.
-- User: ZenX2
-- Date: 11/24/11
-- Time: 3:41 PM
--

newhandler("updateclientinfo",
function(data)

	PEERS = data --easy!
	for k, v in pairs(PEERS) do

		if v.self then LOCALPLAYER = k break end

	end

end)

function GetPeer(ci)

	if PEERS[ci] then

		return PEERS[ci]

	end

end

function LocalPlayer()

	return PEERS[LOCALPLAYER]

end