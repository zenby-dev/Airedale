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

function LHC() connect("localhost:413") end

hook.Add("Draw", "DrawEnts",
function()

	for k, v in pairs(ents) do

		v:Draw()

	end

end)