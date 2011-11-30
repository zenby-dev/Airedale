---
-- Created by IntelliJ IDEA.
-- User: ZenX2
-- Date: 11/21/11
-- Time: 6:14 PM
--
--CLIENT

--TODO: Client object for server --DONE--
--TODO: Input struct for CLIENT -> SERVER --DONE--
--TODO: MOVEY THINGYS SERVER -> CLIENT; draw stuff --DONE--
--TODO: CLIENT DRAWY STUFF AND ALL THAT --DONE--
--TODO: FINISH IMAGE THINGY. --DONE--
--TODO: 

function LHC() connect("localhost:413") end

Menu.Main() --If you want to use my menu system, go ahead
Menu.Open = true

hook.Add("Draw", "DrawEnts",
function()

	local g = love.graphics
	local lp = LocalPlayer()
	local le
	local offset = Vec2(0, 0)

	if lp then

		le = ents[lp.pe]
		if le then offset = le.pos end

	end

	g.push()

	g.translate(-offset.x + g.getWidth() / 2, -offset.y + g.getHeight() / 2)

	for k, v in pairs(ents) do

		v:Draw()

	end

	g.pop()

end)

hook.Add("Update", "UpdateEnts",
function(dt)

	for k, v in pairs(ents) do

		v:Update(dt)

	end

end)