---
-- Created by IntelliJ IDEA.
-- User: ZenX2
-- Date: 11/24/11
-- Time: 3:41 PM
--

newhandler("updateclientinfo",
function(data)

	PEERS = data --easy!

end)

function GetPeer(ci)

	if PEERS[ci] then

		return PEERS[ci]

	end

end