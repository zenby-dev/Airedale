---
-- Created by IntelliJ IDEA.
-- User: ZenX2
-- Date: 11/23/11
-- Time: 11:58 PM
--

for k, v in pairs(love.filesystem.enumerate("server/ents")) do
	if love.filesystem.isDirectory("server/ents/"..v) then
		include("server/ents/"..v.."/entmain.lua")
	end
end
