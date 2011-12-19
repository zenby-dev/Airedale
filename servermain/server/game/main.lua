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
	img.ext.scale = Vec2(7, 7)

end)

hook.Add("Update", "UpdateEnts",
function(dt)

	local clientinfo = {}
	for k, v in pairs(CLIENTS) do --Collect client info

		clientinfo[k] = {}
		for key, value in pairs(v) do

			clientinfo[k][key] = value

		end

	end

	for k, v in pairs(CLIENTS) do --send client info, with the "self" tag for each client (figure out what I mean yourself)

		clientinfo[k].self = true
		send("updateclientinfo", clientinfo, k)
		clientinfo[k].self = nil

	end

	--Update ALL Entities
	for state, entstab in pairs(Ents) do

		for k, v in pairs(entstab) do

			v:Update(dt)

			local tab = {}
			for key, value in pairs(v) do
				tab[key] = value
			end
			send("entsync", {dt, tab})

		end

	end

end)
--solve for j
--j + k*width = n
-- - k*width
--final: j = -k*width + n
--solve for k
--j + k*width = n
--k*width = -j + n
-- / width
--final: k = (-j + n) / width
--testing, j, k is 2, 5, width is 6
--2 + 5*6 = 32
--j = -k*6 + 32
--k = (-j + 32) / 6
--substitution time
--j = -((-j + 32) / 6)*6 + 32
--j = ((-j + 32) / 6)*-6 + 32
--now, we work backwards from here
hook.Add("ClientConnect", "wrawr",
function(ci)

	PlayerCircle(ci)

end)

hook.Add("ClientDisconnect", "wrawr",
function(ci)

	for state, enttab in pairs(Ents) do

		for k, v in pairs(enttab) do

			v:Disconnect(ci)

		end

	end

end)