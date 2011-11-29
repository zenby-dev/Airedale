---
-- Created by IntelliJ IDEA.
-- User: ZenX2
-- Date: 11/21/11
-- Time: 6:12 PM
--
--SERVER

hook.Add("Init", "DERPITYDERP",
function()

	local img = NetImage("client/sprites/airedalemap.png", Vec2(0, 0))
	img.ext.scale = Vec2(3, 3)

end)

hook.Add("Update", "UpdateEnts",
function(dt)

	local clientinfo = {}
	for k, v in pairs(CLIENTS) do --I'll expand this later

		clientinfo[k] = {}
		for key, value in pairs(v) do

			clientinfo[k][key] = value

		end

	end

	for k, v in pairs(CLIENTS) do

		clientinfo[k].self = true
		send("updateclientinfo", clientinfo, k)
		clientinfo[k].self = nil

	end

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