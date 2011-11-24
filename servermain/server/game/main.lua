---
-- Created by IntelliJ IDEA.
-- User: ZenX2
-- Date: 11/21/11
-- Time: 6:14 PM
--
--SERVER

hook.Add("Update", "UpdateEnts",
function(dt)

	--Update Entities
	for k, v in pairs(ents) do

		v:Update(dt)

		local tab = {}
		for key, value in pairs(v) do
			tab[key] = value
		end
		send("entsync", {dt, tab})

	end

end)

hook.Add("ClientConnect", "wrawr",
function(ci)

	PlayerCircle(ci)

end)

hook.Add("ClientDisconnect", "wrawr",
function(ci)

	for k, v in pairs(ents) do

		v:Disconnect(ci)

	end

end)